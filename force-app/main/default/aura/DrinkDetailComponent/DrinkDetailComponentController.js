({
	doInit : function(component, event, helper) {
		
       helper.getdrinks(component);
    
    },
    addToCart :function(component, event, helper) {
		var drinkCount = component.get("v.drinkCount");
        var drinkId = event.getSource().get("v.name");
        console.log('drinkId',drinkId.Price__c);
       console.log('drinkId',JSON.stringify(drinkId));
       component.set("v.drinkCount",drinkCount+1);
       
        var newCount = component.get("v.drinkCount");
         sessionStorage.setItem('drinkCount',newCount);
        sessionStorage.setItem('drinkDetail',drinkId);
        console.log('drinkCount',drinkCount);
        //Get the event using event name. 
        var appEvent = $A.get("e.c:CustomerCartEvt"); 
        
        appEvent.setParams({
            "addToCartClicked":true,
            "drinkCount":drinkCount,
                            "drinkName":drinkId,
                            "drinkPrice":drinkId.Price__c}); 
        appEvent.fire(); 
    }
    
})