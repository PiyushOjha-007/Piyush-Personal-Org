({
	doInit : function(component, event, helper) {
		
       helper.getPizzas(component);
    
    },
    addToCart :function(component, event, helper) {
		var pizzaCount = component.get("v.pizzaCount");
        var pizzaId = event.getSource().get("v.name");
        component.set("v.currentPizza",pizzaId);
        console.log('pizzaId',pizzaId.Price__c);
       console.log('pizzaId',JSON.stringify(pizzaId));
       component.set("v.pizzaCount",pizzaCount+1);
       
        var newCount = component.get("v.pizzaCount");
         sessionStorage.setItem('pizzaCount',newCount);
        sessionStorage.setItem('pizzaDetail',pizzaId);
        console.log('pizzaCount',pizzaCount);
        //Get the event using event name. 
        var appEvent = $A.get("e.c:CustomerCartEvt"); 
        
        appEvent.setParams({
            "addToCartClicked":true,
            "pizzaCount":pizzaCount,
                            "pizzaName":pizzaId,
                            "pizzaPrice":pizzaId.Price__c}); 
        appEvent.fire(); 
    },
    
    showDrinks :function(component, event, helper) {
        alert('HOver');
        var currentPizza = event.target.getAttribute("data-attriVal");
        helper.showAssociatedDrink(component,event,currentPizza);
    }
    
})