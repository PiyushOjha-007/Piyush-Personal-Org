({
	doInit : function(component, event, helper) {
		
        var action = component.get("c.getAllCase");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.CaseList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
        
	},
    
    OncheckboxSelect : function(component, event, helper) {
        var selectedRec = event.getSource().get("v.value");
        var checkBoxCount = component.get("v.checkBoxCount");
        if(selectedRec == true)
        {
			checkBoxCount=checkBoxCount+1;         
        }
        else
        {
          checkBoxCount=checkBoxCount-1;         
        }
        component.set('v.checkBoxCount',checkBoxCount);
    },
    assignUser : function(component, event, helper) {
        component.set("v.openLookupComp",true);
        var casesId = [];
        var getAll = component.find("Box");
        var totalCheckedBox = component.get("v.checkBoxCount");
        console.log('totalCheckedBox'+totalCheckedBox);
        if(!Array.isArray(getAll))
        {
            if(getAll.get("v.value") == true)
            {
                casesId.push(getAll.get("v.text"));
            }
        }
        else
        {
           for(var i =0;i<totalCheckedBox;i++)
           {
               console.log('i'+i);
               if(getAll[i].get("v.value") == true)
               {
                   console.log('getAll'+getAll[i].get("v.text"));
                   casesId.push(getAll[i].get("v.text"));
               }
           }
           
        }
        component.set("v.casesId",casesId);
        
    }
})