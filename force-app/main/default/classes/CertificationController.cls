public class CertificationController {
@AuraEnabled
    public static List <Certification__c> getAllCertificate() {
        
        List<Certification__c> CertiList = [SELECT Associate__c, Certification_Track__c, Entry__c, 
                                    Expert__c, Professional__c from Certification__c];
        
        return CertiList;
    }
    
    @AuraEnabled
    public static List <Case> getAllCase() {
        
        List<Case> CaseList = [SELECT Id,Priority, Type, Status, 
                                    OwnerId, CaseNumber from Case];
        
        return CaseList;
    }
}