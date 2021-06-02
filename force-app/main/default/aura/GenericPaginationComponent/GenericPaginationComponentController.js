({
    doInit: function(component, event, helper)
    {
        console.log('Here');
        var dataLength = component.get("v.allData").length;
        var pageSize = component.get("v.pageSize");
        var totalPages = Math.ceil(dataLength/pageSize);
        component.set("v.totalPages", totalPages);
        // component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
       // component.set("v.allData", );
        component.set("v.currentPageNumber",1);
        console.log('All DATA',component.get("v.allData"));
        helper.buildData(component, helper);
        
        
    },
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber+1);
        helper.buildData(component, helper);
    },
    
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber-1);
        helper.buildData(component, helper);
    },
    
    processMe : function(component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },
    
    onFirst : function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },
    
    onLast : function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    }
})