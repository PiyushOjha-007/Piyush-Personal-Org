import { LightningElement, api ,wire} from 'lwc';
import updateToDos from "@salesforce/apex/ToDoManagerController.updateToDos";
import deleteToDos from "@salesforce/apex/ToDoManagerController.deleteToDos";


export default class ToDoItems extends LightningElement {

@api toDoId;
@api toDoTaskName;
@api toDoDate;
@api toDoDone=false;
@api error;
@api deleteToDo;


get ChildContainer()
{
    if(this.toDoDone)
    {
        return 'ChildContainer completed';
    }
    else
    {
            return 'ChildContainer upcoming';
    }
}

updateToDoHandler()
{
    updateToDos({todoId : this.toDoId}).then(result =>{
        console.log('updated To Do'+result);
            this.toDoDone = result;
            const updateEvent = new CustomEvent('update');
            this.dispatchEvent(updateEvent);
        }).catch(error => {
            console.log('Error here '+JSON.stringify(error));
            
        }) 
}

deleteToDoHandler()
{
    {
        deleteToDos({todoId : this.toDoId}).then(result =>{
            console.log('Delete To Do'+result);
                this.deleteToDo = result;
                const deleteEvent = new CustomEvent('delete');
            this.dispatchEvent(deleteEvent);
            }).catch(error => {
                console.log('Error here '+JSON.stringify(error));
                
            }) 
    }
}
}