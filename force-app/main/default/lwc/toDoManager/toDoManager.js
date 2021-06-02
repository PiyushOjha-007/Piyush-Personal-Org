import { LightningElement, api, track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import addToDotask from "@salesforce/apex/ToDoManagerController.addToDotask";
import getTodayToDos from "@salesforce/apex/ToDoManagerController.getTodayToDos";
export default class ToDoManager extends LightningElement {

   @track time ;
   @track greeting ;
   @track toDos = [];
   
    
    connectedCallback()
    {
        this.getTime();
        this.fetchToDos();
        setInterval( () => {
            this.getTime();
        } , 1000 * 60);
    }

    getTime()
    {
        const date = new Date();
        const hour =date.getHours();
        const minute = date.getMinutes();

        this.time = this.getHour(hour) +':'+ this.getMinute(minute) +' '+ this.getMidday(hour);
        this.setGreetings(hour);
    }

    getHour(hour)
    {
       return hour === 0 ? 12 : hour > 12 ? (hour - 12) : hour;
    }
    getMinute(minute)
    {
        return minute<10 ? '0'+minute : minute;
    }
    getMidday(hour)
    {
        return hour >= 12 ? "PM" : "AM";
    }

    setGreetings(hour)
    {
        console.log('Hour'+hour);
        
        if(hour >= 12 && hour < 17)
        {
              this.greeting = 'Good Afternoon';
        }
        else if(hour >= 17 && hour < 19)
        {
              this.greeting = 'Good Evening';
        }
        else if(hour>19 && hour <24)
        {
            this.greeting = 'Good Night';
        }
        else
        {
            this.greeting = 'Good Morning';
        }
    }

    fetchToDos()
    {
        console.log('Inside FetchToDOs');
        
        getTodayToDos().then(result =>{
            console.log('Fetched Records Successfully'+JSON.stringify(result));
            if(result)
            {
                this.toDos = result;
            }
           
        }).catch(error => {
            console.log('Error in Fetch'+error);
            
        })
    }
    addToDoHandler(event)
    {
        var inp=this.template.querySelector("lightning-input");
        const todos = {
            toDoTaskName : inp.value,
            done : false,
        };
          console.log('Entered Input '+inp.value.length);
          
        if(inp.value.length > 0)
        {
            addToDotask({payload : JSON.stringify(todos)}).then(result =>{
                console.log('To Do Task Inserted'+result);    
                if(result != '')   
                {
                    const evt = new ShowToastEvent({
                        title: 'Success !',
                        message: 'To Do Task Created Successfully',
                        variant: 'success',
                    });
                    this.dispatchEvent(evt);
                }        
                this.fetchToDos();
              }).catch(error => {
                  console.log('Error here '+JSON.stringify(error));
                  
              }) 
        }
        else{
               alert('Enter the ToDo Task First !');
        }
        

        
    
        
    
    }

    updateHandler()
    {
       this.fetchToDos();
    }

    deleteHandler()
    {
         this.fetchToDos();
    }

    
}