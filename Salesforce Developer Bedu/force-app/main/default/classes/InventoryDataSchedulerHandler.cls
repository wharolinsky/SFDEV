public with sharing class InventoryDataSchedulerHandler {
      public static void ScheduleCallOut() {

          String restUrl='https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/';
          HttpRequest requestHttp = new HttpRequest();
          requestHttp.setEndpoint(restUrl);
          requestHttp.setMethod('GET'); 
    
          try {
              Http http = new Http();
               HttpResponse responseHttp = http.send(requestHttp);
            
               if(responseHttp.getStatusCode() == 200) {


                   Map<String, Object> responseJson = (Map<String, Object>) JSON.deserializeUntyped(responseHttp.getBody());    
                   Map<String,object > responseBody =  (Map<String,object>)responseJson.get('body');
                   List< object > responseInventory = (List<object >)responseBody.get('Inventory');
                   List<Inventario__c> uploadInventory = new List<Inventario__c>();
        
                     for(object thisInventory : responseInventory){
            
                        Map<String,object > mInventory = (Map<String,object >)thisInventory;
                        Inventario__c newInventoryEntry=new Inventario__c();
                        newInventoryEntry.Name=((String)mInventory.get('name') );
                        newInventoryEntry.CodigoProd__c=((String)mInventory.get('ProductID') );
                        newInventoryEntry.Cantidad_dis__c=((Integer)mInventory.get('Quan') );
                        newInventoryEntry.Cantidad_apart__c=((Integer)mInventory.get('BlockedQuan')  );

                        uploadInventory.add(newInventoryEntry);
                    }   
                  
                   insert uploadInventory;
             }
         }
                      catch(system.Exception excp) {
                       System.debug('Error: '+excp);
                
                       }  


            
        } 



}