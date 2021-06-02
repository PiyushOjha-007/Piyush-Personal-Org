global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx)
    {
        List<lead> lstOfLead = new List<Lead>();
        for(Lead objlead : [Select id,leadsource from Lead where Leadsource = '' OR Leadsource = null limit 200])
        {
            Lead newLead = new Lead(id=objlead.id);
            newLead.LeadSource = 'Dreamforce';
            lstOfLead.add(newLead);
        }
        insert lstOfLead;
    }
}