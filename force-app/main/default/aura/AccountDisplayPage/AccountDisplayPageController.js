({
	getAccountList: function(cmp){
        var action = cmp.get("c.getAccList");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                
                console.debug('HI',response.getReturnValue().length);
                cmp.set("v.Accounts", response.getReturnValue());
            } else {
                console.debug(response.error[0].message);
            }
        });
	 $A.enqueueAction(action);
    },
    
    getAccountID : function(component, event, helper) {
        
        var accountID = event.srcElement.id;
        alert('Account ID :'+accountID);
        var actionCon = component.get("c.getContactList");
        actionCon.setParams({accID : accountID});
		actionCon.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            
                console.debug('List:'+JSON.stringify(response.getReturnValue()));
                component.set("v.ContactsList", response.getReturnValue());
            } else {
                console.debug(response.error[0].message);
            }
        });
	 $A.enqueueAction(actionCon);
	}
})