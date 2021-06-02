trigger FeedItemTrigger on FeedItem  (before insert,after insert,after update,before update) {

     if(Trigger.isAfter && Trigger.isInsert)
    {
        System.debug('Feed Item After Insert Trigger');
      //  CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        System.debug('Feed Item After Update Trigger');
       // CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
     if(Trigger.isBefore && Trigger.isInsert)
    {
        System.debug('Feed Item Before Insert Trigger');
      //  CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        System.debug('Feed Item isBefore Update Trigger');
       // CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
}