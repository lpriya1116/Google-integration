import { LightningElement, api, wire, track } from 'lwc';
import conlist from '@salesforce/apex/Contactcontrollerlwc.conlist';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    { label: 'Select', type: 'button', initialWidth: 70, typeAttributes: { label: 'Edit', name: 'edit', title: 'Edit', variant: 'base' } },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class contactdetails extends LightningElement {
    @track recordId;
    @track selectedRows = [];

    columns = columns;

    @wire(conlist)
    contacts;

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'edit') {
            this.recordId = row.Id;
        }
    }

    handleSubmit(event) {
        console.log('onsubmit event recordEditForm' + JSON.stringify(event.detail.fields));
    }

    handleSuccess(event) {
        console.log('onsuccess event recordEditForm', event.detail.id);
        this.recordId = null;
    }

    
}