import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import acclist from '@salesforce/apex/accountdetailscontroller.acclist';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Rating', fieldName: 'Rating' }
];

export default class accountdetails extends NavigationMixin(LightningElement) {
    error;
    columns = columns;

    @wire(acclist)
    accounts;

newAccount() {
this[NavigationMixin.Navigate]({
type: 'standard__objectPage',
attributes: {
 objectApiName: 'Account',
     actionName: 'new'
            }
        });
    }
}
