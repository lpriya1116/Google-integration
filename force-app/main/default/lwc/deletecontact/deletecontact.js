import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/deletecontacts.getContacts';
import delSelectedCons from '@salesforce/apex/deletecontacts.deleteContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    {
        label: 'FirstName',
        fieldName: 'FirstName'
    },
    {
        label: 'LastName',
        fieldName: 'LastName'
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone'
    },
    {
        label: 'Email',
        fieldName: 'Email',
        type: 'email'
    }
];

export default class deletecontact extends LightningElement {
    @track data;
    @track columns = columns;
    @track buttonLabel = 'Delete Selected Contacts';
    @track isTrue = false;
    @track recordsCount = 0;
    selectedRecords = [];
    refreshTable;
    error;

    @wire(getContacts)
    contacts(result) {
        this.refreshTable = result;
        if (result.data) {
            this.data = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }

    getSelectedRecords(event) {
        const selectedRows = event.detail.selectedRows;
        this.recordsCount = selectedRows.length;

        // Populate the selectedRecords array with record details
        this.selectedRecords = selectedRows.map(record => ({
            FirstName: record.FirstName,
            LastName: record.LastName,
            Phone: record.Phone,
            Email: record.Email
        }));

        window.console.log('selectedRecords', this.selectedRecords);
    }

    deleteCons() {
        const confirmed = window.confirm(`Are you sure you want to delete ${this.recordsCount} contact(s)?`);

        if (confirmed) {
            delSelectedCons({ lstConIds: this.selectedRecords })
                .then(result => {
                    window.console.log('result', result);

                    this.buttonLabel = 'Delete Selected Contacts';
                    this.isTrue = true;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!',
                            message: this.recordsCount + ' Contacts are deleted.',
                            variant: 'success'
                        })
                    );

                    this.template.querySelector('lightning-datatable').selectedRows = [];

                    // Refresh the data table
                    return refreshApex(this.refreshTable);
                })
                .catch(error => {
                    window.console.log(error);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error while deleting Contacts',
                            message: error.message,
                            variant: 'error'
                        })
                    );
                });
        }
    }

    sendToGoogleSheets() {

        const dataToGoogleSheets = this.selectedRecords;

        gapi.client.load('sheets', 'v4', () => {
            const request = gapi.client.sheets.spreadsheets.values.append({
                spreadsheetId: '1xy8YPLkKgztys463R_RwMQ_ZmowYlEXSXQVoYxk_700',
                range: 'Sheet1', 
                valueInputOption: 'RAW',
                insertDataOption: 'INSERT_ROWS',
                resource: {
                    values: dataToGoogleSheets
                }
            });
            request.execute(response => {
                if (response && !response.error) {
                    const successMessage = `${dataToGoogleSheets.length} records sent to Google Sheets.`;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success!',
                            message: successMessage,
                            variant: 'success'
                        })
                    );
                } else {
                    // Handle error when sending data.
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error sending data to Google Sheets',
                            message: response.error.message,
                            variant: 'error'
                        })
                    );
                }
            });
        });
    }
}
