({
    loadInit : function(component, event, helper){
        
        var UserEmail = $A.get("$SObjectType.CurrentUser.Email");
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        console.log('user id'+userId+'useremail'+UserEmail);
        
        if(userId === undefined || UserEmail === undefined){
            /* default Guest User Id and Email */
            //  UserEmail =  'GuestUser@cisco.com';
            userId =   '005630000038iuv' ; 
            console.log('<<<<user id>>>> '+userId+'<<<<<<useremail>>>> '+UserEmail);
        }
        console.log('<<<<User Id that is being inserted>>>>'+userId);
        component.set("v.FilerecordId",userId);
        //component.set("v.email",UserEmail);
        // component.find("email").set("v.value",UserEmail);
        // component.find("email1").set("v.value",UserEmail);
        helper.getCaseRecordType(component);
        
    },   
    handleUploadFinished : function(component, event, helper) {
        var isDuplicateFile = false;
        var fileCount = component.get("v.fileCount");
        var fn = component.get("v.fn");
        var uploadedFilesName = [];
        uploadedFilesName = event.getParam("files");
        
        // Duplicate File Name Scenario Starts by PO //
        var duplicateFile = component.get("v.duplicateFiles");
        console.log('duplicateFile',duplicateFile);
        
        for(var i = 0 ; i < duplicateFile.length ; i++)
        {
            
            if(duplicateFile[i] == uploadedFilesName[0].name)
            {
                console.log('Duplicate File There');
                isDuplicateFile = true;
                component.set("v.duplicateFilename",uploadedFilesName[0].name);
            }
        }
        // Duplicate File Name Scenario Ends by PO //
        
        console.log('fileCount'+fileCount);
        if(fileCount == 10 || fileCount > 9)
        {    
            var elements = document.getElementsByClassName("showFileCountError");
            elements[0].style.display = 'block';
        }
        else if(isDuplicateFile == true)
        {
            console.log('Duplicate File Found');
            var elements = document.getElementsByClassName("showDuplicateError");
            elements[0].style.display = 'block';
        } 
            else
            {
                var elements = document.getElementsByClassName("showDuplicateError");
                elements[0].style.display = 'none';
                var prevDocId = component.get("v.documentIds");
                var NewfileNames = component.get('v.fileNames');
                var uploadedFiles = [];
                uploadedFiles = event.getParam("files");
                var documentIds = [];
                var fileNames = [];
                for(var i = 0 ; i<uploadedFiles.length ; i++)
                {
                    component.set("v.duplicateFiles["+fileCount+"]",uploadedFiles[0].name);
                    documentIds.push(uploadedFiles[i].documentId);
                    fileNames.push(uploadedFiles[i].name);
                }
                console.log('documentIds',documentIds);
                console.log('fileNames',fileNames);
                component.set("v.fn["+fileCount+"]",uploadedFiles[0].name);
                component.set("v.documentIds",documentIds);
                component.set("v.fileNames",fn);
                component.set("v.documentIds",documentIds+'-'+prevDocId);
                component.set("v.fileCount",fileCount+1);
                console.log('Ended');
            }
    },
    doSave: function(component, event, helper) { 
        
    },
    
    handleSuccess : function(component, event, helper) {
        
        /************************** Lightning File Upload Code Starts by PO*************************************/
        
        
        
        var payload = event.getParams().response;
        var caseObj = JSON.parse(JSON.stringify(payload));
        var caseNumber = caseObj.fields.CaseNumber.value; 
        var docuId = component.get("v.documentIds");
        console.log('Case Id'+payload.id+' Case Number : '+caseNumber+'DOcument ID'+docuId);
        if(docuId == '' || docuId == null || docuId == 'undefined')
        {
            
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/examtiplinesuccess/?casenumber="+caseNumber
            });
            urlEvent.fire();
        }
        else
        {
            /**************************Single File Upload at once Starts*****************************************/
            console.log('Inside Else');
            var allDocId = [];
            var docuIds = component.get("v.documentIds");
            
            var newIds = docuIds.split('-');
            for(var i = 0;i<(newIds.length)-1;i++)
            {
                allDocId.push(newIds[i]);
            }
            console.log('docuIds'+docuIds+' newIds : '+newIds+'Length :'+newIds.length);
            
            console.log('allDocId:',allDocId);
            /**************************Single File Upload at once Ends*****************************************/            
            var action = component.get("c.saveFileWithCase");
            console.log('Here It comes');
            action.setParams({ 
                "docId" : allDocId,
                "caseId" : payload.id
            });
            console.log('Here It comes 2');
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log('state Here'+state);
                if (state === "SUCCESS") {
                    
                    var successInsert = response.getReturnValue();
                    console.log('successInsert Here'+successInsert);
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/examtiplinesuccess/?casenumber="+caseNumber
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
        /*************************** Lightning File Upload Ends ************************************/
        
    },
    doInit: function(component,event,helper){
        /*
        //  alert("Hi Nishant");
        var action = component.get("c.getEmail");
        // alert("Hi Dubey");
        action.setCallback(this , function(response){
            var state = response.getState();
            // console.log('state'+state);
            if (state === "SUCCESS") {
                var getEmail = response.getReturnValue();
                // alert(getEmail);
                console.log('getEmail'+getEmail);
                if(getEmail != ''){
                    component.find('email').set('v.value', getEmail);
                }
                else{
                    component.find('email').set('v.value', ''); 
                }
            }
        });
        $A.enqueueAction(action); 
        */
    },
    itemsChange : function(component, event, helper){
        //   alert('hi');
        var subject = component.find("subject1").get("v.value");
        var desc = component.find("desc1").get("v.value");
        var csco = component.find("csco").get("v.value");
        var email = component.find("email1").get("v.value");
        console.log('<<Difference>>>>'+email);
        // alert(subject);
        
        
        component.find("desc").set("v.value",desc);
        component.find("email").set("v.value",email); 
        component.find("subject").set("v.value",subject);
        component.find("product").set("v.value",csco);
        console.log('<<<<<<>>>>>>>>'+component.get("v.value"));
        
    },
    handleError: function(component, event) {
        var errors = event.getParams();
        console.log('raw response'+errors); 
        console.log("response", JSON.stringify(errors));
    },
    handleDeleteFile : function(component, event) {
        //  Delete File Code Starts By PO
        console.log('Inside delete File');
        var deleteDoc = event.getSource().get("v.name");
        console.log('deleteDoc',deleteDoc);
        var fname = component.get("v.fileNames");
        console.log('File names',fname);
        fname.splice(deleteDoc, 1);
        component.set("v.fileNames",fname);
        console.log('File names after Delte',component.get("v.fileNames"));
        
        // Delete DOcument ID from List
        var updatedDocId;
        var docuIds = component.get("v.documentIds");
        var allDocId = [];   
        var newIds = docuIds.split('-');
        for(var i = 0;i<(newIds.length)-1;i++)
        {
            allDocId.push(newIds[i]);
        }
        allDocId.splice(deleteDoc, 1);
        console.log('allDocId',allDocId);
        for(var i = 0;i<allDocId.length;i++)
        {
            updatedDocId = allDocId[i]+"-"+updatedDocId;
            
        }
        console.log("updatedDocId",updatedDocId);
        component.set("v.documentIds", updatedDocId); 
        
        //  Delete File Code Ends By PO
    }
})