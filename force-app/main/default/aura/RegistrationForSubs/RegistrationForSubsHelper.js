({
    fetchSubscriptionDetail : function(component,event,mobile) {
        console.log('Mobile',mobile);
        var action = component.get("c.fetchSubsDetail");
        action.setParams({ 
            "phoneNumber" :mobile
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var result = response.getReturnValue();
                
                console.log('My Order and Contact Result 1',result.lstContact);
                console.log('My Order and Contact Result 2',result.lstOfMyOrders);
                console.log('My Order and Contact Result Stringify',JSON.stringify(result));
                component.set("v.contactDetail",result.lstContact);
                component.set("v.contactOrderDetail",result.lstOfMyOrders);

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
    
    assignContactToAccount : function(component,contactId,fname) {
        
        var action = component.get("c.assignAccount");
        action.setParams({ 
            "contactId" :contactId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var result = response.getReturnValue();
                if(result == true)
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        type:'success',
                        mode: 'pester',
                        "title": "Success!",
                        "message": "Contact Created Welcome to the Family : "+fname
                    });
                    toastEvent.fire();
                    
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/selecteditems/?contact="+contactId
                    });
                    urlEvent.fire();
                    
                }
                else
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        type:'Error',
                        mode: 'pester',
                        "title": "Error!",
                        "message": "Sorry for the incovenience we will get back to you soon !"
                    });
                    toastEvent.fire();
                }
                component.set("v.isHandleNewUser",false);
                //  component.set("v.isHandleRegisteredUser",false);
                cosnole.log('Contact Associated to The Account :',result);
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