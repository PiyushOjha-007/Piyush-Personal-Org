({
    loadMyCart : function(component,event) {
        
        var pizzaCount = sessionStorage.getItem('pizzaCount');
        var pizzaDetail = sessionStorage.getItem('pizzaDeatil');
        console.log('Session Fetch pizzaCount',pizzaCount);
        console.log('Session Fetch pizzaDetail',pizzaDetail);
        //  var pizzaPrice = event.getParam("pizzaPrice"); 
        //Set the handler attributes based on event data 
        component.set("v.pizzaCount", pizzaCount);
        component.set("v.pizzaDetail", pizzaName);
    },
    
    addOrderToContact : function(component,selectedPizza) 
    {
        var contactId = component.get("v.orderContact");
        console.log('CONTACT ID ',contactId);
        var action = component.get("c.addOrderInContact");
        action.setParams({ 
            "selectedPizza" :selectedPizza,
            "contactId":contactId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var result = response.getReturnValue();
                console.log('Order Result ',result);
                if(result.length > 0)
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        type:'success',
                        mode: 'pester',
                        "title": "Success!",
                        "message": "Your Order is placed with the Order No : "+result[0].Id
                    });
                    toastEvent.fire();
                    
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/allorderpage/?OrderId="+result[0].Id
                    });
                    urlEvent.fire();
                    
                }
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