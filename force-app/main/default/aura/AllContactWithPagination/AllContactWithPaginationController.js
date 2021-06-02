({
	doInit : function(component, event, helper) {
        component.find('select').set("v.value",'Contact');
        var pageno =  component.get("v.pageNumber");
        if(pageno == 1)
        {
            component.set("v.disablePrevious",true);
        }
		helper.getColumnAndAction(component);
        helper.getRecordsHelper(component,event);
        
	},
    onSelect : function(component, event, helper) {
        component.set("v.pageNumber",1);
	    helper.getRecordsHelper(component,event);
	},
    handlePrevious : function(component, event, helper) {
        var pageno =  component.get("v.pageNumber");
       component.set("v.pageNumber",pageno-1);
       alert("Page Number :"+component.get("v.pageNumber"));
       helper.getRecordsHelper(component,event);
    },
    handleNext : function(component, event, helper) {
       var pageno =  component.get("v.pageNumber");
        component.set("v.disablePrevious",false);
       component.set("v.pageNumber",pageno+1);
       helper.getRecordsHelper(component,event);
    },
    
    handleRowAction : function(component, event, helper) {
        var action = event.getParam('action');
        
        if(action.name == 'view')
        {
            var row = event.getParam('row');
            var rowId = row.Id;
            console.log('Row Id'+rowId);
           var navEvt = $A.get("event.force:navigateToSObject");
        navEvt.setParams({
            "recordId": rowId,
            "slideDevName": "detail"
        });
        navEvt.fire();
        }
        if(action.name == 'edit')
        {
            var row = event.getParam('row');
            var rowId = row.Id;
            var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": rowId
        });
        editRecordEvent.fire();
        }
    }
})