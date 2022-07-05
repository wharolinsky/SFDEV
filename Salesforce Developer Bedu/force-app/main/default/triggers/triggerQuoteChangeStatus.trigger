trigger triggerQuote on Quote (after update, before update) {
    
    
    List<Inventario__c> linventary2Update = new List<Inventario__c>();
    
    Map<Id, Quote> mQuoteStatus =  new Map<Id, Quote>();
    Map<Id, Double> mQuoteLineItemQty =  new Map<Id, Double>();
    Set<String> mQuoteValidId =  new Set<String>();
    
 if (trigger.isBefore){
        
        if(trigger.isUpdate){
           
             for (Quote thisQuote : trigger.new) {
                
                
                if( trigger.newMap.get(thisQuote.Id).Status != trigger.oldMap.get(thisQuote.Id).Status){
                    
                    String dQuoteStatusNew = trigger.newMap.get(thisQuote.id).Status;
                    
                    if((dQuoteStatusNew == 'Accepted') && (trigger.newMap.get(thisQuote.Id).LineItemCount== 0) ){
                        
                         trigger.newMap.get(thisQuote.Id).addError('Necesitas que tenga al menos un quote line item');
                       
                        
                        
                    }
                }
            }
          
            
        }
    }    
    if(trigger.isAfter){
        if(trigger.isUpdate){
            
            for (Quote thisQuote : trigger.new) {
                
                
                if( trigger.newMap.get(thisQuote.Id).Status != trigger.oldMap.get(thisQuote.Id).Status){
                    
                    String dQuoteStatusNew = trigger.newMap.get(thisQuote.id).Status;
                    
                    if((dQuoteStatusNew == 'Accepted'||dQuoteStatusNew == 'Approved') && (trigger.newMap.get(thisQuote.Id).LineItemCount> 0) ){
                        
                        String dQuoteValid =  trigger.newMap.get(thisQuote.Id).Id;
                        mQuoteValidId.add(dQuoteValid);
                        
                    }
                }
            }
            system.debug('El id del quote es: '+ mQuoteValidId);
            
            for (QuoteLineItem thisQuoteLineItem : [SELECT Product2Id ,QuoteId ,Quantity FROM QuoteLineItem WHERE QuoteId IN : mQuoteValidId ]) {
                
                // system.debug('la llave es' + thisQuoteLineItem. ); 
                
                Double dQuantity =  (double)mQuoteLineItemQty.get(thisQuoteLineItem.Product2Id) ;
                if(dQuantity == null ){
                    dQuantity=0; 
                }
                
                
                system.debug('La cantidad es ' + dQuantity );
                
                dQuantity+=thisQuoteLineItem.Quantity;
                //system.debug('La cantidad es ' + dQuantity );
                mQuoteLineItemQty.put(thisQuoteLineItem.Product2Id,dQuantity);
                
                system.debug('La cantidad es ' + mQuoteLineItemQty );
                
                
            }
            for(Inventario__c thisInventaryNew : [SELECT Id, Cantidad_dis__c, Product2__c FROM Inventario__c WHERE Product2__c IN :mQuoteLineItemQty.keyset( ) ]){
                
                
                thisInventaryNew.Cantidad_dis__c -= mQuoteLineItemQty.get(thisInventaryNew.Product2__c);
                linventary2Update.add(thisInventaryNew );
                
                system.debug('La lista de updates' + thisInventaryNew  );
                
            }
            
            Update linventary2Update ;
            
            
        }
        
        
    }
    
   
    
    
    
    
    
    
    
    
    
    
}

        }
