import { LightningElement } from 'lwc';

export default class Navigation extends LightningElement {

    previousHandler(){
        this.dispatchEvent(new CustomEvent('previous'));
    }

    nextHandler(){
        this.dispatchEvent(new CustomEvent('next'));
    }
}