({
	onChange : function(component, event, helper) {
		var selectedValue = component.find("selectaura").get("v.value");
        console.log("selectedValue",selectedValue);  
        
        component.set("v.selectedUser","ten");
        component.find("selectaura").set("v.value",component.get("v.selectedUser"));
        console.log('SELCTED USER : '+component.get("v.selectedUser"));
	}
})