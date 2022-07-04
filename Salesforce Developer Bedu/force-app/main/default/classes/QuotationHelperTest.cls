@isTest
public  class QuotationHelperTest {
    

    @testsetup 
    static void data_setup(){
        Product__c prod =  new Product__c();
        prod.Product_Id__c = 'PID-333'; 
        Inventario__c inv =new Inventario__c();
        inv.CodigoProd__c= 'COMP777';
        inv.Cantidad_dis__c= 10.0;

        insert prod;
        insert inv;
    }
    

    @isTest
    static void TestconfirmProductExistByCode (){
        
        Product__c listptst = [SELECT Product_Id__c FROM Product__c WHERE Product_Id__c = :'PID-333' ];
        Product__c listptst2 = [SELECT Product_Id__c FROM Product__c WHERE Product_Id__c = :'PID-444' ];
        QuotationHelper test1 =  new QuotationHelper(); 
        Boolean test1val =test1.confirmProductExistByCode(listptst.Product_Id__c); 
        Boolean test1val2 =test1.confirmProductExistByCode('PID-444'); 
        System.assertEquals(True, test1val);
        System.assertEquals(False, test1val2);


    
        }
    
    @isTest    
    static void TestsearchProductByCode (){
        Inventario__c prodInvtst= [SELECT CodigoProd__c, Cantidad_dis__c FROM Inventario__c WHERE CodigoProd__c= :'COMP777'];
        

        QuotationHelper test2 = new QuotationHelper();
        Double test2val = test2.searchProductByCode(prodInvtst.CodigoProd__c);
        System.assertEquals(10.0, test2val);

        
    }
    @isTest
    public static void TestinitialConfig (){
        QuotationHelper.initialConfig();

       
    }
    @isTest
    public static void TestproductsInInventory (){
        QuotationHelper test3= new  QuotationHelper();
        test3.productsInInventory();

    }
    @isTest
    public  static void StockEmptyAlert() {
        QuotationHelper.StockEmptyAlert();
    }
    
}
