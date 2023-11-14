// GoogleIntegrationLWC.js
import { LightningElement, track } from 'lwc';
import sendDataToGoogleSheets from '@salesforce/apex/googleintegration.sendDataToGoogleSheets';
import getContactList from '@salesforce/apex/googleintegration.getContactList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class GoogleIntegrationLWC extends LightningElement {
    @track contacts = [];
    @track showSpinner = false;

 connectedCallback() {
this.loadContactList();
    }

loadContactList() {
 getContactList()
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                console.error('Error fetching contact data: ' + error);
            });
    }

 sendDataToGoogleSheets() {
this.showSpinner = true;

        sendDataToGoogleSheets()
            .then(result => {
                if (result === 'SUCCESS') {
                    console.log('Data sent to Google Sheets successfully');
                    
                    
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!',
                            message:'Data sent to Google Sheets successfully',
                            variant: 'success'
                        }) )               }                
 else {
                    console.error('Failed to send data to Google Sheets');
                }
            })

            .catch(error => {
                console.error('Error:', error);
            })
            .finally(() => {
                this.showSpinner = false;
            });
    }
}
