import { LightningElement, track, wire } from 'lwc';
import getObjectNames from '@salesforce/apex/multipleintegration.getObjectNames';
import getFieldsForObjectName from '@salesforce/apex/multipleintegration.getFieldsForObjectName';
import sendToGoogleSheets from '@salesforce/apex/multipleintegration.sendToGoogleSheets';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class SelectObjectAndFields extends LightningElement {
    @track selectedObject = '';
    @track selectedFields = [];
    @track objectOptions = [];
    @track fieldOptions = [];
    @track showSpinner = false;

    @wire(getObjectNames)
    objectNames({ error, data }) {
        if (data) {
            this.objectOptions = data.map((objName) => ({
                label: objName,
                value: objName
            }));
        } else if (error) {
            console.error(error);
        }
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.loadFieldsForSelectedObject();
    }

    loadFieldsForSelectedObject() {
        getFieldsForObjectName({ objectName: this.selectedObject })
            .then((result) => {
                this.fieldOptions = result.map((fieldName) => ({
                    label: fieldName,
                    value: fieldName
                }));
                refreshApex(this.objectNames);

            })
            .catch((error) => {
                console.error(error);
            });
    }

    handleFieldChange(event) {
        const field = event.target.value;
        if (event.target.checked) {
            this.selectedFields.push(field);
        } else {
            this.selectedFields = this.selectedFields.filter((item) => item !== field);
        }
    }

    handleSendToGoogleSheets() {
        this.showSpinner = true;

if (this.selectedObject && this.selectedFields.length > 0) {
sendToGoogleSheets({ selectedObject: this.selectedObject, selectedFields: this.selectedFields })
.then(result => {
if (result === 'SUCCESS') {
this.showToast('Success', 'Data sent to Google Sheets successfully', 'success');
 } else {
this.showToast('Error', 'Failed to send data to Google Sheets', 'error');
                    }
                })
                .catch(error => {
                    console.error(error);
                    this.showToast('Error', 'Failed to send data to Google Sheets', 'error');
                })
                .finally(() => {
                    this.showSpinner = false;
                });
        } else {
            this.showToast('Error', 'Please select an object and its fields', 'error');
            this.showSpinner = false;
        }
        
    }
    

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}
