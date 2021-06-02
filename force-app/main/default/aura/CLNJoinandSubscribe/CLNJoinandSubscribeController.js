({
	Subscribe : function(component, event, helper) {
		component.set("v.clickOnSubscribe",true);
	},
    registerLogIn : function(component, event, helper) {
		window.open("https://identity.cisco.com/ui/tenants/global/v1.0/enrollment-ui");
	}
})