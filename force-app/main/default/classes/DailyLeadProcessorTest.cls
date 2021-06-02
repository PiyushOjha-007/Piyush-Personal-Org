@isTest
public class DailyLeadProcessorTest {
    
    static testmethod void testScheduledJob()
    {
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
        List<lead> listOfLead = new List<Lead>();
        
        for(integer i=0;i<=200;i++)
        {
            Lead obj = new Lead();
            obj.Company = 'Zensar';
            obj.LastName = 'lastlead';
            obj.Status = 'Open - Not Contacted';
            listOfLead.add(obj);
        }
        insert listOfLead;
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());
        Test.stopTest();
    }

}