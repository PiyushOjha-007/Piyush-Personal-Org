({
    doInit : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Order No', fieldName: 'Name', type: 'text'},
                {label: 'Order Date', fieldName: 'createdDate', type: 'Date'},
                {label: 'Selected Pizza', fieldName: 'Selected_Pizzas__c', type: 'Text'}
                
            ]);
    },
    handleNewUser : function(component, event, helper) {
        component.set("v.isHandleNewUser",true);
    },
    handleRegisteredUser : function(component, event, helper) {
        component.set("v.isHandleRegisteredUser",true);
    },
    closeModal :function(component, event, helper)
    {
        component.set("v.isHandleNewUser",false);
        component.set("v.isHandleRegisteredUser",false);
    },
    proceedOrder :function(component, event, helper)
    {
        var mobile = component.find("mobile").get("v.value");
        var contactdetail = component.get("v.contactDetail");
        if(contactdetail.length > 0)
        {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                type:'success',
                mode: 'pester',
                "title": "Success!",
                "message": "Welcome !!!! Let's order something"
            });
            toastEvent.fire();
            
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/selecteditems/?contact="+contactdetail[0].Id
            });
            urlEvent.fire();
            
        }
        console.log("Mobile proceed:",mobile);
    },
    onMobileEnetering : function(component, event, helper)
    {
        var mobile = component.find("mobile").get("v.value");
        if(mobile.length == 10)
        {
            console.log('Inside On Blur');
            helper.fetchSubscriptionDetail(component,event,mobile);
        }
    },
    createContact : function(component, event, helper)
    {
        var mobile = component.find("mobile").get("v.value");
        console.log("Mobile:",mobile);
    },
    handleSuccess : function(component, event, helper)
    {
        
        var payload = event.getParams().response;
        var contactObj = JSON.parse(JSON.stringify(payload));
        var fname = contactObj.fields.FirstName.value;
        console.log("Piyush Ojha Success Name",fname);
        helper.assignContactToAccount(component,payload.id,fname);
        
    }
})