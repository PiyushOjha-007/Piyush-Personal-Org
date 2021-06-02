/***********************************************************************************
* File Name: CommunityMyCasesComponentController
* Description : The CLient Side Controller for CommunityMyCasesComponent
* @Author : Piyush Ojha Cisco 
* Created Date : 11-06-2019
* ***********************************************************************************/
({
	doInit:function(component, event, helper) {
        
        component.set('v.columns', [
            {label: 'CaseNumber', fieldName: 'CaseNumber', type: 'Text'},
            {label: 'Subject', fieldName: 'Subject', type: 'text'},
             {label: 'Type', fieldName: 'Case_Create_Product__c', type: 'text'},
            {label: 'CreatedDate', fieldName: 'CreatedDate', type: 'date'},
            {label: 'Status', fieldName: 'Status', type: 'Picklist'}
        ]);
        // Fetch the Case list from the Apex controller
        
        helper.getCaseList(component,event,helper,'');
      //  helper.getSearchCaseList(component); 
      
      },
    handleClick:function(component, event, helper) {
        // Fetch the Case list from the Apex controller
        
        helper.getSearchCaseList(component);   
      },
    handleNameFilterChange: function (component, event, helper) {
        
    helper.getSearchCaseList(component);
 },
      navToHome : function (component, event, helper) {
        let navService = component.find("navService");
        var userId = $A.get( "$SObjectType.CurrentUser.Id" );


        let pageReference = {
            type: "comm__namedPage",
            attributes: {
                pageName: 'home'
            }
        }

        navService.navigate(pageReference);
    },
    navToPagecase : function (component, event, helper) {
        let navService = component.find("navService");
        var userId = $A.get( "$SObjectType.CurrentUser.Id" );


        let pageReference = {
            type: "comm__namedPage",
            attributes: {
                pageName: 'mycases'
            }
        }

        navService.navigate(pageReference);
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
    },    
    
     handleChange : function (component, event,helper) { 
        var statusValue = [];
        statusValue = event.getParam("value");
         console.log('statusValue length : '+statusValue.length);
         for(var i = 0;i<=statusValue.length;i++)
             {
                 
                 if((statusValue.length == 0) ||(statusValue.length == 2))
                 {
                     console.log('Either in 0 or in Both');
                      component.set("v.checkBoxvalue",'');
                      break;
                 }
                 else if(statusValue[i] == 'OpenCases')
                 {
                     console.log('In Open Cases');
                     component.set("v.checkBoxvalue",'OpenCases');
                     break;
                 }
                 else
                 {
                     console.log('In Close Cases');
                     component.set("v.checkBoxvalue",'ClosedCases');
                     break;
                 }
                 
             }
         
        helper.getCaseList(component,event,helper,statusValue);
    
   // Pagination Start Define Code//
     
    },
    //End Pagination Code//
})