public class SingleFileDragController {

    
    @AuraEnabled
    public static boolean saveSingleFileWithCase(List<Id> docId)
    {
        Boolean fileSaved = false;
        List<Id> lstOfContentDocId = new List<Id>();
        system.debug('Doc ID'+docId);
        for(ContentVersion objCV : [SELECT title,OwnerId,Owner.name,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : docId ])
        {
            lstOfContentDocId.add(objCV.ContentDocumentId);
        }
       // Id conDocument = [SELECT title,OwnerId,Owner.name,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId =:docId ].ContentDocumentId;
        system.debug('lstOfContentDocId'+lstOfContentDocId+'Size : '+lstOfContentDocId.size());
        List<ContentDocumentLink> fileLinks = new List<ContentDocumentLink>();
        for(integer i = 0;i<lstOfContentDocId.size();i++)
        {
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = lstOfContentDocId[i];//Add ContentDocumentId
     //   cDocLink.LinkedEntityId = UserInfo.getUserId();
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//, InternalUsers, SharedUsers
        fileLinks.add(cDocLink);
        }
        
      /*  system.debug('conDocument'+conDocument);
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = caseId;
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//, InternalUsers, SharedUsers
        fileLinks.add(cDocLink);
        system.debug('fileLinks List'+fileLinks); */
        if(fileLinks != null && fileLinks.size() > 0)
        {
            Database.SaveResult[] srList = Database.insert(fileLinks,false);
            for (Database.SaveResult sr : srList) 
            {
                if (sr.isSuccess()) {
                   // deleteFilefromUser(docId);
                    System.debug('Successfully inserted FIle with case. File ID: ' + sr.getId());
                    fileSaved = true;
                    return fileSaved;
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }
        
        
        
        return fileSaved;
    }
    
    
    @AuraEnabled
    public static boolean saveFileWithCase(List<Id> docId,Id caseId)
    {
        Boolean fileSaved = false;
        List<Id> lstOfContentDocId = new List<Id>();
        system.debug('Doc ID'+docId+'Case ID'+caseId);
        for(ContentVersion objCV : [SELECT title,OwnerId,Owner.name,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN : docId ])
        {
            lstOfContentDocId.add(objCV.ContentDocumentId);
        }
       // Id conDocument = [SELECT title,OwnerId,Owner.name,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId =:docId ].ContentDocumentId;
        system.debug('lstOfContentDocId'+lstOfContentDocId+'Size : '+lstOfContentDocId.size());
        List<ContentDocumentLink> fileLinks = new List<ContentDocumentLink>();
        for(integer i = 0;i<lstOfContentDocId.size();i++)
        {
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = lstOfContentDocId[i];//Add ContentDocumentId
        cDocLink.LinkedEntityId = caseId;
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//, InternalUsers, SharedUsers
        fileLinks.add(cDocLink);
        }
        
      /*  system.debug('conDocument'+conDocument);
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
        cDocLink.LinkedEntityId = caseId;
        cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
        cDocLink.Visibility = 'AllUsers';//, InternalUsers, SharedUsers
        fileLinks.add(cDocLink);
        system.debug('fileLinks List'+fileLinks); */
        if(fileLinks != null && fileLinks.size() > 0)
        {
            Database.SaveResult[] srList = Database.insert(fileLinks,false);
            for (Database.SaveResult sr : srList) 
            {
                if (sr.isSuccess()) {
                   // deleteFilefromUser(docId);
                    System.debug('Successfully inserted FIle with case. File ID: ' + sr.getId());
                    fileSaved = true;
                    return fileSaved;
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }
        
        
        
        return fileSaved;
    }
   /* public static void deleteFilefromUser(Id docId)
    {
        try
        {
        system.debug('Flow here'+docId);
        List<ContentDocument> lstToDelete = new List<ContentDocument>();
        for(ContentDocument objLink : [Select id,OwnerID from ContentDocument where Id =:docId and OwnerId=: UserInfo.getUserId() ])
        {
            system.debug('Inside It');
            lstToDelete.add(objLink);
        }
        system.debug('lstToDelete'+lstToDelete);
        if(lstToDelete != null)
        {
            Database.delete(lstToDelete,false);
        }
        }
        catch(Exception e)
        {
            system.debug('Exception'+e+'Line Number : '+e.getLineNumber());
        }
    } */
}