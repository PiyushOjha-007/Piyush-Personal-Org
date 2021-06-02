({
	getPizzas : function(component) {
		
         var action = component.get("c.getAllPizza");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.allPizza",response.getReturnValue());
                console.log('Pizzas',response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    
	},
    showAssociatedDrink : function(component,event,currentPizza) {
		console.log('in helper',currentPizza);
         var action = component.get("c.getAllAssociatedDrinks");
        action.setParams({  "currentPizza" : currentPizza  });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.allPizzaDrink",response.getReturnValue());
                console.log('Pizzas with Drink',response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    
	}
})