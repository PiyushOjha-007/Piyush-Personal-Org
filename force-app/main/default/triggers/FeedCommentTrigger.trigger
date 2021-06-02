trigger FeedCommentTrigger on FeedComment (before insert,after insert,after update) {

    if(Trigger.isAfter && Trigger.isInsert)
    {
        System.debug('Feed Comment After Insert Trigger');
      //  CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        System.debug('Feed Comment After Update Trigger');
       // CommunityNotificationForFeedCommentClass.notifyUser(Trigger.New,Trigger.OldMap);
    }
}