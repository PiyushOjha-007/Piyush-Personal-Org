({
	executeEvent : function(component, event, helper) {
		
        console.log('I am Child Component');
        var cmpEvent = component.getEvent("bubbleEvent");
        cmpEvent.setParams({
            "mytext" : "Piyush Here Inside Child COmponent" });
        cmpEvent.fire();
	}
})