global class NotifyUserForBestAnswerFeedBatch implements Database.Batchable<sObject>
{

     global Database.QueryLocator start(Database.BatchableContext bc) {
         Datetime halfHourBack = Datetime.now().addMinutes(-15);
         String Feedquery = 'SELECT Id, bestcommentId FROM FeedItem where bestCommentId != null AND LastModifiedDate >= :halfHourBack ';
         system.debug('Query Returned :'+Feedquery);
         return Database.getQueryLocator(Feedquery);
    }
    global void execute(Database.BatchableContext bc, List<FeedItem> lstOfFeedItem){
       
        Set<id> setOfBestCommentId = new Set<Id>();
        List<FeedComment> lstOfBestFeedComment = new List<FeedComment>();
        
        for(FeedItem objFeeds : lstOfFeedItem)
        {
            setOfBestCommentId.add(objFeeds.bestcommentId);
        }
        system.debug('Best Comment Ids :'+setOfBestCommentId);
        for(FeedComment objComment : [Select id,commentBody,createdById from FeedComment where Id IN : setOfBestCommentId])
        {
                       lstOfBestFeedComment.add(objComment);
        }
        NotifyUserAfterBestAnswerClass.sendNotification(lstOfBestFeedComment);
        
    }    
    global void finish(Database.BatchableContext bc){
        
    }  
}