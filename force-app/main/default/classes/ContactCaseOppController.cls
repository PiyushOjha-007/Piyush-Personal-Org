public class ContactCaseOppController {

@AuraEnabled    
public static List<SObject> getRecords(String selectedObject,String pageSize, String pageNumber)
{
    Integer pSize = Integer.valueOf(pageSize);
    Integer pNumber = Integer.valueOf(pageNumber);
    Integer OffsetValue = pNumber*pSize;
    system.debug('Page Size'+pageSize+'pageNumber:'+pageNumber+'OffsetValue'+OffsetValue);
    String strSOQL = 'Select id,ownerid,owner.name,createdDate from '+selectedObject+' limit :pSize OFFSET : OffsetValue';
    List<SObject> listOfRecords = Database.query(strSOQL);
    system.debug('List Of Records :'+listOfRecords);
    return listOfRecords;
}    
}