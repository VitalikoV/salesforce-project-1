import { LightningElement, wire, api } from 'lwc';
import changeName from '@salesforce/apex/ChangeAllOppNames.changeNames';
import userId from '@salesforce/user/Id';

export default class ChangeNameOpportunity extends LightningElement {

    @api completedJobs;
    @api error;


    handleClick(){
        changeName({userId : this.userId})
        .then(
        //     (result) => {
        //     this.completedJobs = result;
        //     console.log(result);
        // }
        )
        .catch((error) =>{
            this.error = error;
        });
    }
    // @wire(changeName, {userId : userId})
    // changeName({data, error}) {}
}