import { LightningElement, wire, api } from 'lwc';
import getAttachmentsForRecord from '@salesforce/apex/produtscontroller.getAttachmentsForRecord';

export default class productcarousel extends LightningElement {
    @api recordId; 

    @wire(getAttachmentsForRecord, { recordId: '$recordId' })
    attachments;
}
