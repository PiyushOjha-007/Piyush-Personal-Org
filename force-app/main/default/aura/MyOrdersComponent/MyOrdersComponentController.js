({
	fetchOrder : function(component, event, helper) {
		
        component.set('v.mycolumns', [
            {label: 'Order Name', fieldName: 'Name', type: 'text'},
                {label: 'Order Date', fieldName: 'CreatedDate', type: 'date'},
                {label: 'Order Details', fieldName: 'Selected_Pizzas__c', type: 'text'},
                {label: 'Customer Name', fieldName: 'Contact__r.Name', type: 'text '}
            ]);
        var action = component.get("c.fetchAllOrder");

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.myOrderList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
	
})