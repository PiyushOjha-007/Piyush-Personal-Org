public with sharing class CIN_EinsteinBotCaseInsertApexClass {

    public class ShowCaseNumberClass {
        @InvocableVariable(required=true)
        public String insertedCaseNumber;
    }
    public class insertCaseNowClass {
        @InvocableVariable(required=true)
        public String caseTitleFromUser;
    }
    
    @InvocableMethod(label='Insert Case and Get Case Number')
    public static List<ShowCaseNumberClass> insertCaseRecord(List<insertCaseNowClass> insertCaseSubject)
    {
        List<String> caseSubjectList = new List<String>(); 
        List<ShowCaseNumberClass> lstOfRetunCaseNumber = new List<ShowCaseNumberClass>();
        // Get the order numbers from the input
        for (insertCaseNowClass caseInput : insertCaseSubject) {
            caseSubjectList.add(caseInput.caseTitleFromUser);
        }
        List<Case> lstOfCase = new List<Case>();
        Case objCase = new Case();
        objCase.Subject = caseSubjectList[0];
        objCase.Origin = 'Web';
        objCase.Status = 'New';
        lstOfCase.add(objCase);
        
        Database.SaveResult[] saveResultList = Database.insert(lstOfCase);
        System.debug('My saveResultList'+saveResultList);
        for (Database.SaveResult sr : saveResultList) {
            System.debug('SR HERE'+sr);
            if (sr.isSuccess()) {
                ShowCaseNumberClass showCase = new ShowCaseNumberClass();
                Id caseId = sr.getId();
                System.debug('Success ID Case'+caseId);
                String CaseNo = [Select casenumber from Case where Id =:caseId ].CaseNumber;
                showCase.insertedCaseNumber = CaseNo;
                lstOfRetunCaseNumber.add(showCase);
                System.debug('Success Case Number'+CaseNo+'lstOfRetunCaseNumber'+lstOfRetunCaseNumber);
                return lstOfRetunCaseNumber;
            }
            else {
                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    return null;
                }
            }
        }
        return null;
    }
}