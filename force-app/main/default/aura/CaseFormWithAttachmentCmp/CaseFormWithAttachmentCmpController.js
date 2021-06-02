({
    doInit:function(component, event, helper){
    var UserEmail =  $A.get("$SObjectType.CurrentUser.Email");
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.recordId",userId);
        component.set("v.email",UserEmail);
        
     },
    handleUploadFinished : function(component, event, helper) {
        
        var uploadedFiles = event.getParam("files");
        console.log('uploadedFiles',uploadedFiles);
        var documentId = uploadedFiles[0].documentId;
        var fileName = uploadedFiles[0].name;
        var fileExtension = fileName.split('.').pop();
        console.log('documentId',documentId);        
        component.set("v.documentId",documentId);
        component.set("v.fileName", fileName);
        
    },
    doSave: function(component, event, helper) {
       /* if(component.find("fileId").get("v.files") == null )
        {
            console.log('In DO SAVE');     
        }
        else 
        {
            
          //  var payload = event.getParams();
          //  console.log(payload.id);
            var newCase = component.get("v.newCase");
            var mainproduct = component.find("MainProduct").get("v.value");
             var mainproduct1 = component.find("Product1").get("v.value");
            var mainproduct2 = component.find("Product2").get("v.value");
            var mainproduct3 = component.find("Product3").get("v.value");
            var sub = component.find("subject").get("v.value");
            var desc = component.find("desc").get("v.value");
           // var product = component.find("product").get("v.value");
            //var subproduct = component.find("subproduct").get("v.value");
            //var countrycode = component.find("countrycode").get("v.value");
            //var areacode = component.find("areacode").get("v.value");
            var business = component.find("business").get("v.value");
            var mobile = component.find("mobile").get("v.value");
            
            newCase.Case_Close_Product__c = mainproduct;
            newCase.Case_Close_Product_Level_1__c = mainproduct1;
            newCase.Case_Close_Product_Level_2__c = mainproduct2;
            newCase.Case_Close_Product_Level_3__c = mainproduct3;
            newCase.Subject  = sub;
            newCase.Description = desc;
           // newCase.Case_Create_Product__c = product;
           // newCase.Case_Create_Sub_Product__c = subproduct;
            //newCase.Country_Code__c = countrycode;
            //newCase.Area_Code__c = areacode;
            newCase.Phone__c = business;
            newCase.Mobile_Phone__c = mobile;
            
            
            event.preventDefault();
            helper.uploadHelper(component, event,newCase);
            
        } 
        */
    },
 
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
        
    },
    
    handleSuccess : function(component, event, helper) {
       /************************** Lightning File Upload Code Starts by PO*************************/
        
        
        var payload = event.getParams().response;
        var caseObj = JSON.parse(JSON.stringify(payload));
        var caseNumber = caseObj.fields.CaseNumber.value; 
        var docuId = component.get("v.documentId");
        console.log('Case Id'+payload.id+' Case Number : '+caseNumber+'DOcument ID'+docuId);
        
        if(docuId == '' || docuId == null || docuId == 'undefined')
        {
            
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/caseconfirmation/?casenumber="+caseNumber
            });
            urlEvent.fire();
        }
        else
        {
            
        var action = component.get("c.saveFileWithCase");
            console.log('Here It comes');
        action.setParams({ 
            "docId" : docuId,
            "caseId" : payload.id
        });
        console.log('Here It comes 2');
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('State Here'+state);
            if (state === "SUCCESS") {
                
                var successInsert = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/caseconfirmation/?casenumber="+caseNumber
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
    phoneChange:function(component, event, helper){
        var business = component.find("business").get("v.value");
       var mobile = component.find("mobile").get("v.value");
        
         component.find("businesshidden").set("v.value",business);
         component.find("mobilehidden").set("v.value",mobile);
    },
    
   itemsChange : function(component, event, helper){
    //   alert('hi');
        var subject = component.find("subject1").get("v.value");
       var desc = component.find("desc1").get("v.value");
       
       
       // alert(subject);
         
        
         component.find("desc").set("v.value",desc);
         
         component.find("subject").set("v.value",subject);
         
    },
    handleChange : function(component, event, helper){
        var business = component.find("business");
       var mobile = component.find("mobile");
        var phoneValues = [];
        phoneValues = event.getParam("value");
         console.log('phoneValues length : '+phoneValues.length);
         for(var i = 0;i<=phoneValues.length;i++)
             {
                 if(phoneValues.length == 1)
                 {
                     console.log('None Selected');
                      $A.util.removeClass(business, "slds-has-error");
                   $A.util.removeClass(mobile, "slds-has-error");
                     component.set("v.mobileChecked",false);
                     component.set("v.businessChecked",false);
                     break;
                 }
                 if(phoneValues.length == 3)
                 {
                     console.log('All Selected');
                     component.set("v.mobileChecked",true);
                     component.set("v.businessChecked",true);
                     break;
                 }
                 if(phoneValues[i]=='business')
                 {
                     console.log('Business here',phoneValues[i]);
                     component.set("v.businessChecked",true);
                    $A.util.removeClass(mobile, "slds-has-error");
                     component.set("v.mobileChecked",false);
                     break;
                 }
                 if(phoneValues[i]=='mobile')
                 {
                     console.log('MObile here',phoneValues[i]);
                     $A.util.removeClass(business, "slds-has-error");
                     component.set("v.mobileChecked",true);
                     component.set("v.businessChecked",false);
                     break;
                 }
                 
             }
    } 
    
})