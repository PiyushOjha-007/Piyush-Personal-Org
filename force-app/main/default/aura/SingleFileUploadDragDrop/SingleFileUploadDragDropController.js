({ 
    doInit : function(component, event, helper) {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        console.log('User Id',userId);
        component.set("v.recordId",userId);
     
    },
    
    handleUploadFinished : function(component, event, helper) {
         
        var uploadedFiles = [];
        uploadedFiles = event.getParam("files");
        console.log('uploadedFiles'+uploadedFiles);
        var fname = component.get("v.fileNames");
        
        component.set("v.fileNames",fname+uploadedFiles[0].name);
        var documentIds = [];
        var fileNames = [];
        for(var i = 0 ; i<uploadedFiles.length ; i++)
        {
            documentIds.push(uploadedFiles[i].documentId);
            fileNames.push(uploadedFiles[i].name);
        }
        console.log('documentIds',documentIds);
        console.log('fileNames',fileNames);
       // component.set("v.documentIds",documentIds);
       // component.set("v.fileNames",fileNames);
        helper.saveSingleFile(component,event,documentIds,fileNames);
       
        
        
        
    },
    submitCase : function(component, event, helper) {
        
            console.log('In Submit Case');     
         //   var docId = component.get("v.documentId");
            
        
    },
    handleSuccess : function(component, event, helper) {
       
          var filenames = component.get("v.fileNames");   
        var documentIds = component.get("v.documentIds");  
        
         var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+fileName+" Uploaded successfully."
        });
        toastEvent.fire();
    }
})