({
	getAllUser : function(component,event) {
        var action = component.get("c.getUserInfo");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log('Piyush LOG',storeResponse);
                console.log('Piyush LOG JSON',JSON.stringify(storeResponse));
                component.set("v.options", storeResponse);
            }
        });
        $A.enqueueAction(action);
		
	}
})