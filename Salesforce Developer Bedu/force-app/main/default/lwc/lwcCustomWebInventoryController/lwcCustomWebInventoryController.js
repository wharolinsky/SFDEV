import { LightningElement, api  } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin} from 'lightning/navigation';
import createQLI from '@salesforce/apex/CustomWebInventoryController.createQLI';

import QuoteLineItem_OBJECT from '@salesforce/schema/QuoteLineItem';
import Product2Id_FIELD from '@salesforce/schema/QuoteLineItem.Product2Id';
import UnitPrice_FIELD from '@salesforce/schema/QuoteLineItem.UnitPrice';
import Quantity_FIELD from '@salesforce/schema/QuoteLineItem.Quantity';
import PricebookEntryId_FIELD from '@salesforce/schema/QuoteLineItem.PricebookEntryId';
import QuoteId_FIELD from '@salesforce/schema/QuoteLineItem.QuoteId';




export default class AccountCreator extends NavigationMixin(LightningElement) {
    @api recordId;
    Product2Id='';
    UnitPrice=0.0;
    Quantity=0.0;
    PricebookEntryId='';
    QuoteId='';
    
    handleChange(event){
        if(event.target.label=='Product2Id'){
            this.Product2Id =event.target.value;
        }
        if(event.target.label=='UnitPrice'){
            this.UnitPrice=event.target.value;
        }
        if(event.target.label=='Quantity'){
            this.Quantity =event.target.value;
        }
        if(event.target.label=='PricebookEntryId'){
            this.PricebookEntryId =event.target.value;
        }
        if(event.target.label=='QuoteId'){
            this.QuoteId=event.target.value;
        }
       

    }

    submithandler(event){
        event.preventDefault();   
        console.log('submithandleralgo');
        console.log(JSON.parse(JSON.stringify(event.detail.fields)));     

        
        console.log('Calling APEX');
        createQLI({
            inputfields : event.detail.fields
        }).then((results)=>{
                console.log('success');
                console.log(results);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title:'Success',
                        message:'Quote Line Item Created',
                        variant:'success'
                    })
                );
                
                this[NavigationMixin.Navigate]({
                    type:'standard__recordPage',
                    attributes:{
                        recordId:results,
                        objectApiName:'QuoteLineItem',
                        actionName:'view'
                    },
                });
            }
        ).catch((error)=>{
            console.log('error');
            console.log(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Error',
                    message: 'There was error creating the Quote Line Item',
                    variant:'error'
                })
            );
        });


    }

    QuoteLineItemCreation(){
        const fields ={};
        fields[Product2Id_FIELD.fieldApiName]=this.Product2Id;
        fields[UnitPrice_FIELD.fieldApiName]=this.UnitPrice;
        fields[Quantity_FIELD.fieldApiName]=this.Quantity;
        fields[PricebookEntryId_FIELD.fieldApiName]=this.PricebookEntryId;
        fields[QuoteId_FIELD.fieldApiName]=this.QuoteId;
      

        const recordInput ={apiName:QuoteLineItem_OBJECT.objectApiName, fields};

        createRecord(recordInput)
        .then(account =>{
            this.accountId=account.id;
            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Success',
                    message:'Account created',
                    variant:'success',
                }),
            );
            this[NavigationMixin.Navigate]({
                type:'standard__recordPage',
                attributes:{
                    recordId:account.id,
                    objectApiName:'QuoteLineItem',
                    actionName:'view'
                },
            });


        })
        
        .catch(error=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title:'Error creating record',
                    message:error.body.message,
                    variant:'error',
                }),
            );
        });   
        
    }
}