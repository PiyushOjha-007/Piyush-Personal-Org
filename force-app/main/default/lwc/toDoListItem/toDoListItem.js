import { LightningElement, api } from 'lwc';

export default class ToDoListItem extends LightningElement {
    @api toDoTaskName;
    @api toDoDone;
    @api toDoCompletedDate;
    @api toDoStartDate;

    get itemContainer()
    {
         return this.toDoDone ? 'itemContainer completed' : 'itemContainer upcoming';
    }
}