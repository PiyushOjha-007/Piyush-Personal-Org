({
	doInit : function(component, event, helper) {
        component.set("v.firstPage",1);
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text', sortable : true},
            {label: 'Email', fieldName: 'Email__c', type: 'email', sortable : true},
            {label: 'AccountNumber', fieldName: 'AccountNumber', type: 'Text', sortable : true},
            {label: 'Phone', fieldName: 'Phone', type: 'phone', sortable : true}]);
		helper.getAllAccounts(component,event);
	},
    handleNext : function(component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber",pageNumber+1);
        helper.onNextClick(component,event);		
	},
    handlePrevious : function(component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber",pageNumber-1);
        helper.onPreviousClick(component,event);		
	}
})