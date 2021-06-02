({
    doInit : function(component, event, helper) {
        
        var mydate = new Date().toLocaleString("en-US", {timeZone: timezone})
        console.log('Date Instance with Salesforce Locale timezone : '+mydate);
        
        
        var localDate = new Date();
        console.log('Local Date in Your Laptop : '+localDate);
        var timezone = localDate.getTimezoneOffset();
        console.log('Local DateTIme in Your Laptop',timezone); 
        
        
        var action = component.get("c.getDownTimeRecords");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var mainDetails = response.getReturnValue();
                component.set("v.MaintenaceDetail",response.getReturnValue());
                console.log('Apex DateTime',mainDetails.Start_Time__c,'Lightning DataTime',mydate);
                console.log('Apex DateTime',mainDetails.End_Time__c,'Lightning DataTime',mydate);
                component.set("v.IsMaintenanceOn",true);
                if(mainDetails.Start_Time__c == mydate )
                {
                    component.set("v.IsMaintenanceOn",true);
                }
                if(mainDetails.End_Time__c == mydate )
                {
                    component.set("v.IsMaintenanceOn",false);
                }
                console.log('DownTime recods',mainDetails.Downtime_Message__c);
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