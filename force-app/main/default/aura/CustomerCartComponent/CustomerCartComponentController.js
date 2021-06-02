({
    doInit :function(component, event, helper) {
        
        //  helper.loadMyCart(component,event);
        var url = window.location.href;
        var contactId = url.split('=')[1];
        console.log('URL',url,'contact',contactId);
        component.set("v.orderContact",contactId);
        var selectedPizza = component.get("v.pizzaDetail");
        console.log('SelectedPizza:',selectedPizza);
        if(contactId == null || contactId == 'undefined')
        {
            console.log('In Disable');
            component.set("v.disableCheckout",true);
        }
        
    },
    
    checkOut : function(component, event, helper) {
        var selectedPizza = component.get("v.pizzaDetail");
        console.log('SelectedPizza:',selectedPizza);
        var placeOrder = component.get("v.disableCheckout");
        console.log('placeOrder',placeOrder);
        if(placeOrder == false)
        {
            helper.addOrderToContact(component,selectedPizza);
        }
        else
        {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                type:'warning',
                mode: 'pester',
                "title": "Error ! ! !",
                "message": "Please Get The Customer Contact First to place the Order  !!! "
            });
            toastEvent.fire();
        }
        
        
        
    },
    cancel:function(component, event, helper) {
        alert('Cancel');
    },
    CartLoad :function(component, event, helper) {
        
        
        
        //  var pizzaCount = sessionStorage.getItem('pizzaCount');
        //  var pizzaDetail = sessionStorage.getItem('pizzaDeatil');
        console.log('Session Fetch pizzaCount',pizzaCount);
        console.log('Session Fetch pizzaDetail',pizzaDetail);
        var totalamt = component.get("v.TotalAmount");
        var addToCartClicked = event.getParam("addToCartClicked"); 
        var pizzaPrice = event.getParam("pizzaPrice"); 
        var pizzaCount = event.getParam("pizzaCount");
        var pizzaDetail = event.getParam("pizzaName");
        
        var drinkCount = event.getParam("drinkCount"); 
        var drinkName = event.getParam("drinkName");
        var drinkPrice = event.getParam("drinkPrice");
        
        component.set("v.TotalAmount",drinkPrice+pizzaPrice+totalamt);
        console.log('In Cart pizzaCount',pizzaCount);
        //Set the handler attributes based on event data 
        component.set("v.addToCartClicked", addToCartClicked);
        component.set("v.pizzaCount", pizzaCount+1);
        component.set("v.drinkCount", drinkCount+1);
        
        
        component.set("v.pizzaDetail["+pizzaCount+"]", pizzaDetail);
        
    },
    handleSectionToggle: function (cmp, event) {
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            cmp.set('v.activeSectionsMessage', "All sections are closed");
        } else {
            cmp.set('v.activeSectionsMessage', "Open sections: " + openSections.join(', '));
        }
    },
    cancelItem :function (component, event) {
        var TotalAmount = component.get("v.TotalAmount");
        var pizzaId = event.getSource().get("v.name");
        //  helper.removeLead(component, index);
        console.log('Pizza To Delete',pizzaId);
        var updatedPizzaDetails = component.get("v.pizzaDetail");
        var pizzaPrice = updatedPizzaDetails[pizzaId].Price__c;
        console.log('pizzaPrice delte',pizzaPrice);
        updatedPizzaDetails.splice(pizzaId, 1);
        component.set("v.TotalAmount",TotalAmount-pizzaPrice);
        console.log('updatedPizzaDetails',updatedPizzaDetails);
        component.set("v.pizzaDetail", updatedPizzaDetails);
        
    }
})