({
	saveSingleFile : function(component,event,documentIds,fileNames) {
		//var payload = event.getParams().response;
       // var caseObj = JSON.parse(JSON.stringify(payload));
        //var caseNumber = caseObj.fields.CaseNumber.value; 
      //  var docuIds = component.get("v.documentIds");
       // console.log('Case Id'+payload.id+' Case Number : '+caseNumber+'DOcument ID'+docuIds);
      //  alert('In HAndle Success');
       var action = component.get("c.saveSingleFileWithCase");
        action.setParams({ 
            "docId" : documentIds
            
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('State Here'+state);
            if (state === "SUCCESS") {
                alert("From server: values" + response.getReturnValue());
               var successInsert = response.getReturnValue();
                console.log('successInsert : '+successInsert);
             //   component.set("v.fileNames",fileNames);
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