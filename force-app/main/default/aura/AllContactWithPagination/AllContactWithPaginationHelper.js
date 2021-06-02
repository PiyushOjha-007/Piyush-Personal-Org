({
	getRecordsHelper : function(cmp,event) {
		var selectedObject = cmp.find("select").get("v.value");
        cmp.set("v.SelectedObject",selectedObject);
        var pageNumber = cmp.get("v.pageNumber");
        var pageSize = cmp.get("v.pageSize");
        var actionInit = cmp.get("c.getRecords");
        actionInit.setParams({
            'selectedObject':selectedObject,
            'pageSize' : pageSize,
            'pageNumber' : pageNumber
        });
        actionInit.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
                console.log('Result:'+JSON.stringify(resultData)+'Length'+resultData.length);
                if(resultData.length < cmp.get("v.pageSize")){
                    cmp.set("v.isLastPage", true);
                } else{
                    cmp.set("v.isLastPage", false);
                } 	
               cmp.set("v.dataSize", resultData.length);
                cmp.set("v.data", resultData);
            }
        });
        $A.enqueueAction(actionInit);
	},
    getColumnAndAction : function(cmp,event)
    {
      var actions = [
            {label: 'Edit', name: 'edit'},
            {label: 'Delete', name: 'delete'},
            {label: 'View', name: 'view'}
        ];
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'OwnerId', fieldName: 'OwnerId', type: 'text'},
            {label: 'CreatedDate', fieldName: 'CreatedDate', type: 'Date'},
            {type: 'action', typeAttributes: { rowActions: actions } } 
        ]);
    }
})