/**
 * SentimentAnalysis class used to return the sentiment analysis conducted on a group of text.
 * 
 * @author      Jessica Amposta
 * @since       7/15/19
 **/

public class SentimentAnalysis {
	
    /**
     * 
     * This method is used to find the sentiment analysis for the 
     * ratings/comments/suggestions field from a list of campaign members.
     * It will take the sentiment received from the Einstein Sentiment API 
     * and update the 'Sentiment Analysis' field in Salesforce.
     * 
     * 
     * @param List<Id>	The list of Ids for the Campaign Members to be updated.
     * 
     **/
    
    @future (callout = True)
    public static void CMSentAn (List<Id> CmpgnMemIds) {
	
        //Create a new Campaign Member list based off the Ids
        List <CampaignMember> CmpgnMemList = [select CampaignMember.Survey_Sent__c, CampaignMember.Rating_Reason_Suggestions__c, CampaignMember.Sentiment_Analysis__c 
                                              from CampaignMember where Id in: CmpgnMemIds];
        
        //Assign variables that will be used for conditions and inserting into the "Sentiment Analysis" field on CampaignMember
        string poslabel = 'positive';
        string neglabel = 'negative';
        string neulabel = 'neutral';
        double positive;
        double negative;
        double neutral;
        
        //Conditional for CampaignMember list bounds
        if(CmpgnMemList.size() >0) {
            //Create an instance of the Einstein Service class
            EinsteinService einstein = new EinsteinService();
            
            //Loop through each Campaign Member in the list
            for (Integer cm=0 ; cm < CmpgnMemList.size(); cm++){
                
                //Only look at campaign members with an event that has the Send NPS box checked and who filled out the survey with comments/suggestions
                if (CmpgnMemList[cm].Survey_Sent__c == True && CmpgnMemList[cm].Rating_Reason_Suggestions__c != null){
                    
                    //Assign a List from the SentimentAnalysisResponse class as the response from the Einstein Sentiment API
                    SentimentAnalysisResponse resp = einstein.findSentiment(CmpgnMemList[cm].Rating_Reason_Suggestions__c);
                    
                    //Conditional for SentimentAnalysisResponse list bounds
                    if (resp.probabilities.size() > 0) {
                        //Assign the positive, negative, and neutral percentages according to the Einstein Sentiment API Response
                        //Size of response varies according to text
                        for (Integer i=0 ; i < resp.probabilities.size(); i++) {
                            if (resp.probabilities[i].label == 'positive') {
                                positive = resp.probabilities[i].probability;
                            }
                            else if(resp.probabilities[i].label == 'neutral'){
                                neutral = resp.probabilities[i].probability;
                            }
                            else {
                                negative = resp.probabilities[i].probability;
                            }
                        }
                        
                        //Insert Label for highest percentage into Sentiment Analysis field
                        if( negative > positive && negative > neutral ) { 
                            CmpgnMemList[cm].Sentiment_Analysis__c = neglabel.toUppercase(); 
                        } 
                        else if( positive > negative && positive > neutral ) { 
                            CmpgnMemList[cm].Sentiment_Analysis__c = poslabel.toUppercase();
                        } 
                        else { 
                            CmpgnMemList[cm].Sentiment_Analysis__c = neulabel.toUppercase(); 
                        } 
                    }
                    
                    else {
                        CmpgnMemList[cm].Sentiment_Analysis__c = 'no Einstein response received';
                    } 
                }
                else if (CmpgnMemList[cm].Survey_Sent__c == True && CmpgnMemList[cm].Rating_Reason_Suggestions__c == null){
                    CmpgnMemList[cm].Sentiment_Analysis__c='N/A';
                }
                
            }
            
        }
                    
        //DML Statement
        Database.SaveResult[] srList = Database.update(CmpgnMemList, false);
        
        // Iterate through each returned result
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully updated CampaignMember: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('CampaignMember fields that affected this error: ' + err.getFields());
                }
            }
        }
        
    }
}
