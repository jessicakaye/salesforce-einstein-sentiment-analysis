/**
 * Trigger used to invoke the Campaign Member SentimentAnalysis method.
 * 
 * @author      Jessica Amposta
 * @since       7/15/19
 **/


trigger GetSentimentAnalysis on CampaignMember (after update, after insert, after delete, after undelete) {
    
    //Conditional so that future method invocation is not made if the current execution context is future or batch
    if(!System.isFuture() && !System.isBatch()){
    
        //If the event is insert or undelete, this list takes new values or else it takes old values
        List<CampaignMember> CampaignMemberList = (Trigger.isInsert|| Trigger.isUnDelete) ? Trigger.new : Trigger.old;
        
        //Create list Ids to pass into the SentAnalysisMethod
        List<Id> CmpgnMemIds = new List<Id>();
        for (CampaignMember CMs: CampaignMemberList) {
        CmpgnMemIds.add(CMs.Id);
        }
            
        //Call the SentAnalysisMethod
        SentimentAnalysis.CMSentAn(CmpgnMemIds);
    }
}
