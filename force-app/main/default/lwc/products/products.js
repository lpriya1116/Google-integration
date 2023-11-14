import { LightningElement, wire, api } from 'lwc';
import relatedFiles from '@salesforce/apex/produtscontroller.relatedFiles';

export default class products extends LightningElement {

    @wire(relatedFiles, { ProductId : '$ProductId' })
    idPhotoDetails({ data, error }){
        if (data) {
            this.photoUrl = data; 
         }else if(error){
            console.log('ERROR', JSON.stringify(error));
        }
    }
}
