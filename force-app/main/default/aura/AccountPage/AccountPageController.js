({
	getAcc : function(component) {
        
        var action = component.get("c.getAccounts");
        
      //  action.setParams({'accObj': component.get("v.accountObj")});
      //  var AccName = component.find("AccName").get("v.value");
        
            
         console.log('The action value is: '+action);
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.accounts',response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
       
	}
})