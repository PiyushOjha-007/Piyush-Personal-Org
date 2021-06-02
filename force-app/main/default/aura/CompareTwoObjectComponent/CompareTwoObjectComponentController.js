({
	doInit : function(component, event, helper) {
		
	},
    handleClick : function(component, event, helper) {
		component.set("v.showAllData",true);
        component.set("v.showData",false);
        helper.processAllData(component,event);
	},
    onChange: function (component, Event, helper) {
        var selectedValue = component.find('select').get('v.value');
        component.set("v.selectedValue",selectedValue);
        if(selectedValue == 'None')
        {
            component.set("v.showAllData",false);
            component.set("v.showData",false);
        }
        else
        {
            if(selectedValue == 'InsertingData')
            {
                component.set("v.showAllData",false);
                helper.showInsertingRecords(component,event);
            }
            else if(selectedValue == 'DeletingData')
            {
                component.set("v.showAllData",false);
                helper.showDeletingRecords(component,event);
            }
            else
            {
                
            }
            component.set("v.showData",true);
        }
        
    }
})