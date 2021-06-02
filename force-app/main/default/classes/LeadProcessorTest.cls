@isTest
public class LeadProcessorTest {

    @testSetup 
    static void setup()
    {
        List<lead> leadlist = new List<Lead>();
        for (Integer i=0;i<10;i++) {
            Lead objlead = new Lead();
            objlead.LastName = 'lead'+i;
            objlead.Company = 'Zensar';
            objlead.Status = 'Open -Not Contacted';
            leadlist.add(objlead);
        }
    }
    
    static testmethod void testbatch()
    {
        List<lead> leadlist = new List<Lead>();
        for (Integer i=0;i<10;i++) {
            Lead objlead = new Lead();
            objlead.LastName = 'lead'+i;
            objlead.Company = 'Zensar';
            objlead.Status = 'Open -Not Contacted';
            leadlist.add(objlead);
        }
        insert leadlist;
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        
        System.assertEquals(10, [select count() from lead where leadsource = 'Dreamforce']);
    }
}