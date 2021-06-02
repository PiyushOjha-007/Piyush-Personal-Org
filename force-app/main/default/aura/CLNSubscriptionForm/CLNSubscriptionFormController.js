({
	closeModel : function(component, event, helper) {
		component.set("v.isFormOpen", false);
	},
    openModel : function(component, event, helper) {
		component.set("v.isFormOpen", true);
	}
})