({
    showInsertingRecords : function(component,event) {
        
        var action=component.get('c.processingDataToInsert');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
                
                component.set("v.DataList", response.getReturnValue());
                component.set("v.TotalNewData",response.getReturnValue().length);
                console.log('In Inserting Helper'+JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
        
    },
    showDeletingRecords : function(component,event) {
        
        var action=component.get('c.processingDataToDelete');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
                
                component.set("v.DataList", response.getReturnValue());
                component.set("v.TotalMissingData",response.getReturnValue().length);
                console.log('In Deleting Helper'+JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
        
    },
    
    processAllData : function(component,event) {
        
        var action=component.get('c.processAllObjectsData');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
               component.set("v.AllDataList", response.getReturnValue());
                var listWrap = JSON.stringify(component.get("v.AllDataList"));
                console.log('Processing Data Helper'+listWrap);
                component.set("v.TotalMismatch",response.getReturnValue().length);
                
            }
        });
        $A.enqueueAction(action);
        
    }
    
})