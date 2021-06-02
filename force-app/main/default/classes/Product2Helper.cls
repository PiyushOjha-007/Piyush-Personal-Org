public class Product2Helper {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name = :Constants.INVENTORY_ANNOUNCEMENTS
        OR Name = :('TEST'+Constants.INVENTORY_ANNOUNCEMENTS)
        LIMIT 1
    ];

    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<Product2> lstOfProd){
        List<Product2>  lstofannProd = new List<Product2>();
        for ( Product2 p : lstOfProd )
        {
            if (p.Id != null && (
                    ( p.Family == 'Entree' && p.Quantity_Remaining__c < 20 )||
                    ( p.Family == 'Side' && p.Quantity_Remaining__c < 10 )||
                    ( p.Family == 'Dessert' && p.Quantity_Remaining__c < 15 )||
                    ( p.Family == 'Beverage' && p.Quantity_Remaining__c < 5 )
                )
            )
            {
               lstofannProd.add(p);
            }
        }
        if(lstofannProd != null)
        {
            PostAlerts(lstofannProd);
        }
        //ToDo: Declare a List of Product2 records named needsAnnouncement

        //ToDo: Declare a Map of Strings to Inventory_Setting__mdt records

        //ToDo: Loop through a query of Inventory_Setting__mdt records and populate the Map with Name as the key

        //ToDo: Loop through the Products in newList
        // Use the corresponding Inventory Setting record to determine the correct Low Quantity Alert
        // If the Product's Quantity Remaining has been changed to less than the Low Quantity Alert
        //      add it to the needsAnnouncement list

        //ToDo: Pass records to the postAlerts method
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
        List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        for ( Product2 p : productList ){
            ConnectApi.AnnouncementInput input = new ConnectApi.AnnouncementInput();
            input.expirationDate = Date.today().addDays(1);
            input.sendEmails = false;
            ConnectApi.MessageBodyInput bodyInput = new ConnectApi.MessageBodyInput();
            ConnectApi.TextSegmentInput textInput = new ConnectApi.TextSegmentInput();
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
            textInput.text = p.Name + ' , ' + Constants.INVENTORY_LEVEL_LOW;
            bodyInput.messageSegments = new List<ConnectApi.TextSegmentInput>();
            bodyInput.messageSegments.add(textInput);
            input.body = bodyInput;
            input.parentId = COLLABORATION_GROUP[0].Id;
           	toPost.add(input);
            // ToDo: Construct a new AnnouncementInput for the Chatter Group so that it:
            // expires in a day
            // does not notify users via email.
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
        }
        AnnouncementQueueable q = new AnnouncementQueueable();
        q.toPost = toPost;
        System.enqueueJob(q);
        // ToDo: Create and enqueue an instance of the announcementQueuable class with the list of Products
    }
}