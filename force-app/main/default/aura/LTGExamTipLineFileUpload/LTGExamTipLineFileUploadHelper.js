({
    MAX_FILE_SIZE: 5000000, //Max file size 4.5 MB 
    CHUNK_SIZE: 250000,      //Chunk Max size 750Kb 
    
    uploadHelper: function(component, event,newCase) {
        
        // start/show the loading spinner   
        component.set("v.showLoadingSpinner", true);
        
        var fileInput = component.find("fileId").get("v.files");
        
        var file = fileInput[0];
        var self = this;
        
        if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner", false);
            component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
        }
        
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
            
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            self.uploadProcess(component, file, fileContents,newCase);
        });
        
        objFileReader.readAsDataURL(file);
        
        
    },
    
    uploadProcess: function(component, file, fileContents,newCase) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
        
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '',newCase);
    },
    
    
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId,newCase) {
        // call the apex method 'saveChunk'
        
        
        
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        
        action.setParams({
            parentId: newCase,
            fileName: file.name,
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
        
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                // update the start position with end postion
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                // check if the start postion is still less then end postion 
                // then call again 'uploadInChunk' method , 
                // else, diaply alert msg and hide the loading spinner
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                   // alert('your File is uploaded successfully');
                    component.set("v.showLoadingSpinner", false);
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": "/examtiplinesuccess/?casenumber="+attachId
                    });
                    urlEvent.fire(); 
                    
                }
                // handel the response errors        
            } else if (state === "INCOMPLETE") {
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // enqueue the action
        $A.enqueueAction(action);
    },
    
    getCaseRecordType : function(component) {
        
        var action = component.get("c.getRecordType");
        console.log('Here It comes 2');
        action.setCallback(this, function(response) {
            var state = response.getState();
             console.log('state Here'+state);
            if (state === "SUCCESS") {
                
                var caseRecordtype = response.getReturnValue();
                console.log('caseRecordtype Here'+caseRecordtype);
                component.set("v.caseWorkingRecordType",caseRecordtype);
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