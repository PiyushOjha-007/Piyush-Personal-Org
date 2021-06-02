({
	init : function(component, event, helper) {
		helper.getAllUser(component,event,helper);
        component.barMethod();
	},
    onChange:function(component, event, helper) {        
       // var selected = component.find('select').get('v.value');
        alert('Selected User :');
        component.foo();
       // component.set("v.selectedValue",selected);
	},
    bar : function(component, event, helper) {        
        
        alert('Hey Buddy');
        
	}
})