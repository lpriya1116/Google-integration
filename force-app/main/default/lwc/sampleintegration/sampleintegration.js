import { LightningElement, wire, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript } from 'lightning/platformResourceLoader';
import GOOGLE_SHEETS_API from '@salesforce/resourceUrl/GoogleSheetsAPI';

export default class Sampleintegration extends LightningElement {
    @api selectedObject = '';
    @track selectedFields = [];
    @track objectOptions = [];
    @track fieldOptions = [];

    // Load the Google Sheets API script when the component is initialized
    connectedCallback() {
        loadScript(this, GOOGLE_SHEETS_API)
            .then(() => {
                // Google Sheets API script is loaded, you can use it here
            })
            .catch(error => {
                console.error('Error loading Google Sheets API script', error);
            });
    }

    // Fetch object metadata and fields
    @wire(getObjectMetadata)
    wiredObjectMetadata({ data, error }) {
        if (data) {
            this.objectOptions = data;
        } else if (error) {
            this.showToast('Error', error.body.message, 'error');
        }
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        // Fetch fields based on the selected object
        getObjectFields({ selectedObject: this.selectedObject })
            .then(result => {
                this.fieldOptions = result;
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    handleFieldChange(event) {
        this.selectedFields = event.detail.value;
    }

    handleSubmit() {
        // Implement your code to send data to Google Sheets here
        // Remember to use the loaded Google Sheets API script for interaction
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }
}
