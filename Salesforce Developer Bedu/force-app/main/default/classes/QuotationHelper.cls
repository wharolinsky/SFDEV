public with sharing class QuotationHelper implements QuotationSync {

    //public string body { get; set;}
   // public string userID { get; set;}

    public static void initialConfig (){

        Account a=new Account(Name='Compumundo');
        
        insert (a);

        Account b =new Account(Name='Compuworld');
        
        insert (b);
        System.debug(a);
       
    }
    public void productsInInventory (){
        List<Inventario__c> inv =[SELECT Name, Cantidad_dis__c, Cantidad_apart__c,CodigoProd__c  FROM Inventario__c WHERE CodigoProd__c LIKE 'COMP%'];
        for (Inventario__c i : inv){
            String DatInv= 'El producto '+ i.Name + ' tiene una cantidad disponible de ' + i.Cantidad_dis__c +' y estan apartados '+ i.Cantidad_apart__c ;
            System.debug(DatInv);

        }

        
    }
  

    public Boolean confirmProductExistByCode (String ProdCod){
        List<Product__c> listp=[SELECT Product_Id__c FROM Product__c WHERE Product_Id__c = :ProdCod ];

            if (  listp.Size() != 0 ) {
            
                System.debug(' hay match');
                return true; 
            }
            else { 
                System.debug('no hay match');
                return false;
            }

        }

    public Double  searchProductByCode (String InvCod){
       List<Inventario__c> prodInv= [SELECT CodigoProd__c,	Cantidad_dis__c FROM Inventario__c WHERE CodigoProd__c= :InvCod];

        if(prodInv.Size() != 0){
            Double a ;
            for (Inventario__c i : prodInv){

                a = i.Cantidad_dis__c;
            
             }
        System.debug( 'la cantidad es:'+ a);
         return a ; 
        }
        else{
             System.debug('la cantidad es:' + 0.0);
             return 0.0;
        }
        
    
    
    }
/*
    public static void triggermethod(List<QuoteLineitem> triglist){
       // List<QuoteLineItem> qtl=new List<QuoteLineItem>();
            
             List<Product2> prd= new List<Product2>() ;
             List<Inventario__c> inv= new List<Inventario__c>();
            
            String pid;
            Double qty;
            String codPd;
            Double qtyAp;
            Double nQty;
            String prCd;
            
     for( QuoteLineItem q : triglist){
     
           pid= q.Product2Id;
           qty= q.Quantity;
         
          }
        
     for( Product2 p : [SELECT Id, Name, ProductCode FROM Product2 WHERE Id =: pid]){
             
          prCd= p.ProductCode ;
             
         
          }
          
            
         for( Inventario__c i : [SELECT Id, Name, CodigoProd__c,Cantidad_apart__c FROM Inventario__c WHERE CodigoProd__c =: prCd]){
                 
           codPd= i.CodigoProd__c;
         qtyAp= i.Cantidad_apart__c;
          nQty= qtyAp + qty;
                 
         }
              
     
     System.debug('id producto '+pid);
     System.debug('cantidad dada de alta en el quote '+ qty);
     System.debug('codigo producto'+ prCd);
     System.debug('codio producto en inventario'+codPd);
     System.debug('cantidad apartada en inventario '+ qtyAp);
     System.debug('cantidad nueva en el inventario'+nQty);
     
     
     
     }*/
   @InvocableMethod
   public  static void StockEmptyAlert() {

    UserInfo.getUserName();
  
    List<Inventario__c> prodInv= [SELECT CodigoProd__c,	Cantidad_dis__c, LastModifiedby.Username FROM Inventario__c ];

    if(prodInv.Size() != 0){
       
        for (Inventario__c i : prodInv){

            string b = i.CodigoProd__c;
            string c =i.LastModifiedById;
            FeedItem objPost = new FeedItem();
            objPost.ParentId = UserInfo.getUserId();
            objPost.Body = 'El producto '+ b +' se quedo sin inventario a las '+c;
            insert objPost;

            
           
        
           
        }
       
         
    
    
     }

  } 

}