import { LightningElement, api, track, wire } from 'lwc';
import getAllRelatedContacts from '@salesforce/apex/ProjectController.getAllRelatedContacts';

const columns = [
    {label: 'Name', fieldName: 'nameUrl', type: 'url', sortable: "true",
            typeAttributes: {label: { fieldName: 'Name' },
            value:{fieldName: 'linkName'}, target: '_blank'}
			},
    {label: 'Email', fieldName: 'Email', type: 'email', sortable: "true"},
    {label: 'Phone', fieldName: 'Phone', type: 'phone', sortable: "true"},      
];

export default class ContactListLwc extends LightningElement {
    @api recordId;
    @track page = 1;
    @track items = [];
    @track data = [];
    @track columns;
    @track startRecord = 1; //start record position per page
    @track endRecord = 0; //end record position per page
    @track pageSize = 5; //default value
    @track totalRecountCount = 0; //total record quantity(data length)
    @track totalPage = 0; //total number of pages
    @track sortBy = 'email';
    @track sortDirection= 'asc';

    @wire(getAllRelatedContacts, {recordId : '$recordId'})
    wiredContacts({ error, data }) {
        if (data) {
            let nameUrl;
            this.items = data.map(row => { 
                nameUrl = `/${row.Id}`;
                return {...row , nameUrl} 
            });
            this.totalRecountCount = data.length;
            this.recalculatingParameters();
            this.columns = columns;
        } else if (error) {
            this.error = error;
            console.log("Something went wrong:");
            console.log(error);
        }
    }

    recalculatingParameters(){
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        this.data = this.items.slice(0,this.pageSize); 
        this.endRecord = this.pageSize;
    }

    //method invokes when you click on the previous button
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1;
            this.displayRecordPerPage(this.page);
        }
    }

    //method invokes when you click on the next button
    nextHandler() {
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1;
            this.displayRecordPerPage(this.page);            
        }             
    }

    displayRecordPerPage(page){
        this.startRecord = ((page -1) * this.pageSize);
        this.endRecord = (this.pageSize * page);

        //In order to end record was not higher than quantity of total records
        if(this.endRecord > this.totalRecountCount){
            this.endRecord = this.totalRecountCount;
        } 

        this.data = this.items.slice(this.startRecord, this.endRecord);

        //increment by 1 to display the startRecord count
        //The aim is to show "Showing from 1..." instead of "Showing from 0..."
        this.startRecord = this.startRecord + 1;
    }

    //when sort arrow is pressed
    updateSorting(event){
        let field = event.detail.fieldName;
        let direction = event.detail.sortDirection;

        this.sortBy = field;
        this.sortDirection = direction;

        this.sortData(field, direction);
    }

    //sort logic
    sortData(fieldName, sortDirection){
        let sortResult = Object.assign([], this.items);
        this.items = sortResult.sort(function(a,b){

            if(a[fieldName] < b[fieldName]){
                return sortDirection === 'asc' ? -1 : 1;
            }else if(a[fieldName] > b[fieldName]){
                return sortDirection === 'asc' ? 1 : -1;
            }else{
                return 0;
            }

        });
        this.recalculatingParameters();
        this.displayRecordPerPage(1);
    }

    // options for combobox
    get options(){
        return [
            {label: '5', value: '5'},
            {label: '10', value: '10'},
            {label: '15', value: '15'}
        ];
    }

    changeOption(event){
        let val = event.detail.value;
        this.pageSize = val;
        this.recalculatingParameters();
        displayRecordPerPage(1);
    }   
}