public with sharing class CustomWebInventoryController {
    public CustomWebInventoryController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<QuoteLineItem> getInventoryList(){
        try {
            return [SELECT Id, QuoteId, Product2Id, Quantity, Quote.Status FROM QuoteLineItem];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Quote> getQuoteList(){
        try {
            return [SELECT Id, Name FROM Quote];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static void createQLI(Map<String,Object> inputfields){
        try {
            system.debug(inputfields);
            
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
