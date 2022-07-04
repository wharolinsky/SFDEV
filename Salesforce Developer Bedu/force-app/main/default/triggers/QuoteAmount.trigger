trigger QuoteAmount on QuoteLineItem (after insert,after update) {
    
    System.debug('QuoteLineItem Trigger Start');
    
    if(trigger.isbefore){
        System.debug('QuoteLineItem Trigger isBefore');

        
          
        //debug
        
    }  
    
    if(trigger.isafter){
        
        
    
    List<Inventario__c> linventary2Update = new List<Inventario__c>();
    
    
    Map<ID, Double > mQuantityByProduct =  new Map<ID, Double>();
    
    for (QuoteLineItem thisQuoteLineItem : trigger.new) {
        
        //object perro = (Object)mQuantityByProduct ;
      
        Double dQuantity =  mQuantityByProduct.get(thisQuoteLineItem.Product2Id) ;
        
        
       
        
        if(dQuantity == null ){
            
            dQuantity=0;
            
        }
        
        dQuantity+=thisQuoteLineItem.Quantity;
        mQuantityByProduct.put(thisQuoteLineItem.Product2Id,dQuantity);
        
        
    }
    
    
    for(Inventario__c thisInventaryNew : [SELECT Id, Cantidad_apart__c, Product2__c FROM Inventario__c WHERE Product2__c IN :mQuantityByProduct.keyset( ) ]){
        
        
        thisInventaryNew.Cantidad_apart__c += mQuantityByProduct.get (thisInventaryNew.Product2__c);
        linventary2Update.add(thisInventaryNew );
        
        
    }
    
    
    
    
    Update linventary2Update ;
        
    }
    
    
    
    
    
    
    /*
    String sjson ='  {"statusCode":200,"body":{"Inventory":[{"name":"CL1010_Inv","ProductID":"CL1010","Quan":625,"BlockedQuan":92},{"name":"MC1020_Inv","ProductID":"MC1020","Quan":3332,"BlockedQuan":24},{"name":"DLL1030_Inv","ProductID":"DLL1030","Quan":6301,"BlockedQuan":44}]}}';

    Map<String,object > responseJson = new Map<String,object >();
    Map<String,object > responseBody =  (Map<String,object>)responseJson.get('body');
    List< object > responseInventory = (List<object >)responseBody.get('Inventory');
    
    for(object thisInventory : responseInventory){
        
        Map<String,object > mInventory = (Map<String,object >)thisInventory;
        System.debug((String)mInventory.get('name') );
        
        
    }*/
   
  
}