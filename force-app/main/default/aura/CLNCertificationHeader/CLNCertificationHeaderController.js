({
	doInit : function(component, event, helper) {
		
        component.set('v.mycolumns', [
            {label: 'Certification Track', fieldName: 'Certification_Track__c', type: 'text'},
                {label: 'Entry', fieldName: 'Entry__c', type: 'text'},
                {label: 'Associate', fieldName: 'Associate__c	', type: 'text'},
                {label: 'Professional', fieldName: 'Professional__c', type: 'text '},
            {label: 'Expert', fieldName: 'Expert__c', type: 'text '}
            ]);
        var action = component.get("c.getAllCertificate");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var lst = [];
            lst = response.getReturnValue();
            
            if (state === "SUCCESS") {
                
                component.set("v.CertiList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
	}
})