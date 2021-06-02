import { LightningElement, track } from 'lwc';
import getMapOfToDos from "@salesforce/apex/ToDoManagerController.getMapOfToDos";

export default class ToDoList extends LightningElement {

    @track toDos = [];
    connectedCallback()
    {
        
        this.fetchAllToDos();
       
    }

    fetchAllToDos()
    {
        console.log('Inside All ToDOs');
        
        getMapOfToDos().then(result =>{
            console.log('Fetched Records Successfully'+JSON.stringify(result));
            if(result)
            {
                for(let key in result) {
                    
                    if (result.hasOwnProperty(key)) 
                    { 
                        console.log('KEY'+Date.parse(key)+'VALUE'+JSON.stringify(result[key]));
                        this.toDos.push({value:result[key], key:Date.parse(key)});
                    }
                }
            }
            
            
           
        }).catch(error => {
            console.log('Error in Fetch'+error);
            
        })
    }

}