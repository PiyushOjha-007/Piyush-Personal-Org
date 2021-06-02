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
        var fn1 = component.get("v.fNames");
        console.log('FN1 : ',fn1[0]);
        for(var i = 0 ; i< fn1.length ; i++)
        {
            if(fn1[i] === uploadedFiles[0].name)
            {
                console.log('Duplicate File There');
                alert('You have uploaded this file before');
            }
        }
        
        for(var i = 0 ; i<uploadedFiles.length ; i++)
        {
            
            component.set("v.fNames["+count+"]",uploadedFiles[0].name);
           // component.set("v.fNames",fn1);
            if(uploadedFiles.length > 1)
            {
                component.set("v.multiSelect",true);
                component.set("v.fileNames",fileNames);
                component.set("v.documentIds1["+i+"]",uploadedFiles[i].documentId);
            }
            else
            {
                component.set("v.fn["+count+"]",uploadedFiles[0].name);
                component.set("v.multiSelect",false);
                component.set("v.documentIds2",uploadedFiles[0].documentId+','+prevDocId);
                component.set("v.fileNames",fn);
            }
            documentIds.push(uploadedFiles[i].documentId);
            fileNames.push(uploadedFiles[i].name);
        }
        console.log('documentIds1',component.get("v.documentIds1"));
        console.log('documentIds2',component.get("v.documentIds2"));
        console.log('fileNames',fileNames);
        
        
        
        
        component.set("v.countFile",count+1);
        
        console.log('DOCCSSS: 1',component.get("v.documentIds1").length);
        
        console.log('DOCCSSS: 2',component.get("v.documentIds2").length);
        var lb = $A.get("$Label.c.ContactInfo");
        console.log('Lable :',lb);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": lb
        });
        toastEvent.fire();
        
        
        
    },
    submitCase : function(component, event, helper) {
        
        console.log('In Submit Case');     
        //   var docId = component.get("v.documentId");
        
        
    },
    handleSuccess : function(component, event, helper) {
        var payload = event.getParams().response;
        var allDocId1 = [];
        var allDocId2 = [];
        var newIds;
        var caseObj = JSON.parse(JSON.stringify(payload));
        var caseNumber = caseObj.fields.CaseNumber.value; 
        var docuIds1 = component.get("v.documentIds1");
        var docuIds2 = component.get("v.documentIds2");
        var multiSelect = component.get("v.multiSelect");
        
        console.log('multiSelect :',multiSelect);
        
       
            newIds = docuIds2.split(',');
            for(var i = 0;i<(newIds.length)-1;i++)
            {
                allDocId2.push(newIds[i]);
            }
        
        
        
        console.log('docuIds1 : '+docuIds1+'allDocId2 : '+allDocId2);
        alert('In HAndle Success');
        var action = component.get("c.saveFileWithCase");
        action.setParams({ 
            "docId1" : docuIds1,
            "docId2" : allDocId2,
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