({ 
    doInit : function(component, event, helper) {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        console.log('User Id',userId);
        component.set("v.recordId",userId);
     
    },
    
    handleUploadFinished : function(component, event, helper) {
        var count = component.get("v.countFile");
      console.log('count',count);
         var prevDocId = component.get("v.documentIds");
        var uploadedFiles = [];
        uploadedFiles = event.getParam("files");
        console.log('uploadedFiles',uploadedFiles);
        var documentIds = [];
        var fileNames = [];
        
        var fn = component.get("v.fn");
        for(var i = 0 ; i<uploadedFiles.length ; i++)
        {
            documentIds.push(uploadedFiles[i].documentId);
            fileNames.push(uploadedFiles[i].name);
        }
        console.log('documentIds',documentIds+'length : '+documentIds.length);
        console.log('fileNames',fileNames);
        if(documentIds.length > 1)
        {
            component.set("v.multiSelect",true);
            component.set("v.fileNames",fileNames);
            component.set("v.documentIds",documentIds);
        }
        else
        {
            component.set("v.fn["+count+"]",uploadedFiles[0].name);
            
            component.set("v.documentIds",documentIds+'-'+prevDocId);
            component.set("v.fileNames",fn);
        }
        component.set("v.countFile",count+1);
        
        
        
        
        
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+component.get("v.fileNames")+" Uploaded successfully."
        });
        toastEvent.fire();
        
        
        
    },
    submitCase : function(component, event, helper) {
        
            console.log('In Submit Case');     
         //   var docId = component.get("v.documentId");
            
        
    },
    handleSuccess : function(component, event, helper) {
       var payload = event.getParams().response;
        var allDocId = [];
        var newIds;
        var caseObj = JSON.parse(JSON.stringify(payload));
        var caseNumber = caseObj.fields.CaseNumber.value; 
        var docuIds = component.get("v.documentIds");
        var multiSelect = component.get("v.multiSelect");
        console.log('Document Length :',docuIds.length);
        console.log('multiSelect :',multiSelect);
        if(docuIds.length > 1 && multiSelect == true)
        {
            for(var i = 0;i<docuIds.length;i++)
            {
                allDocId.push(docuIds[i]);
            }
        }
        else
        {
            newIds = docuIds.split('-');
            for(var i = 0;i<(newIds.length)-1;i++)
            {
                allDocId.push(newIds[i]);
            }
        }
        
        
       console.log('allDocId'+allDocId+'Length :'+allDocId.length);
        alert('In HAndle Success');
       var action = component.get("c.saveFileWithCase");
        action.setParams({ 
            "docId" : allDocId,
            "caseId" : payload.id
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('State Here'+state);
            if (state === "SUCCESS") {
                alert("From server: values" + response.getReturnValue());
               var caseID = response.getReturnValue();
                console.log('caseID : '+caseID);
                
                var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "/casecreated/?caseID="+caseID
    });
    urlEvent.fire();
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action); 
        
    }
})