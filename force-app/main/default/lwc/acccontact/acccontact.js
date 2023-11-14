import { LightningElement,api,wire } from 'lwc';
import getContacts from '@salesforce/apex/acccontactcontroller.getContacts';
import {getRecord} from 'lightning/uiRecordApi';
export default class Acccontact extends LightningElement {
    @api recordId;
 @wire(getRecord, {recordId: '$recordId', fields: 'Account.Name'})
    record;

@wire(getContacts, {accId:'$recordId'})
contacts;

get name(){
    return this.record.data.fields.Name.value;
}


}