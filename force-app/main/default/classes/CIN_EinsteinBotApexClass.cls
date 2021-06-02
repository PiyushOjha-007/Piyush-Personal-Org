public with sharing class CIN_EinsteinBotApexClass {
    
    
    
    public class CaseOutput {
        @InvocableVariable(required=true)
        public String sCaseStatus;
        @InvocableVariable(required=true)
        public String sCaseSubject;
        @InvocableVariable(required=true)
        public DateTime sCaseCreatedDate;
        @InvocableVariable(required=true)
        public String sCaseNotAccessibleError;
    }
    
    public class CaseInput {
        @InvocableVariable(required=true)
        public String sCaseNumber;
    }
    
    @InvocableMethod(label='Get Case Status')
    public static List<CaseOutput>  getCaseStatus(List<CaseInput> caseInputs) {
        Set<String> caseNumbers = new Set<String>(); 
        
        // Get the order numbers from the input
        for (CaseInput caseInput : caseInputs) {
            caseNumbers.add(caseInput.sCaseNumber);
        }
        
        // Get the order objects from the set of order numbers
        List<Case> caseList = [SELECT Id,CreatedDate,OwnerId, Status,Subject FROM Case where (Subject IN :caseNumbers OR CaseNumber IN : caseNumbers) AND OwnerId=:UserInfo.getUserId()];
        
        
        List<CaseOutput> caseOutputs = new List<CaseOutput>();
        CaseOutput caseOutput = new CaseOutput();
        System.debug('caseList HERE '+caseList);
        if(caseList.size() > 0)
        {
            caseOutput.sCaseStatus = caseList[0].Status;
            caseOutput.sCaseSubject = caseList[0].Subject;
            caseOutput.sCaseCreatedDate = caseList[0].CreatedDate;
            caseOutput.sCaseNotAccessibleError = 'The Case '+caseInputs[0].sCaseNumber+' is in '+caseList[0].Status+' Status.';
            caseOutputs.add(caseOutput);
            System.debug('caseOutputs HERE '+caseOutputs);
            return caseOutputs;  
        }
        else
        {
            
            caseOutput.sCaseStatus = null;
            caseOutput.sCaseSubject = null;
            caseOutput.sCaseCreatedDate = null;
            caseOutput.sCaseNotAccessibleError = 'Sorry ! You are not authorized to access this Case.';
            caseOutputs.add(caseOutput);
            System.debug('caseOutputs HERE '+caseOutputs);
            return caseOutputs;  
            
        }
    }
    
    
    
    }