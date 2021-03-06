/**
 * 
 * 
 * @author      Jessica Amposta
 * @since       7/16/2019
 *
 * This class calls the Einstein Sentiment 
 * API class to find the sentiment of a block 
 * of text.
 *
 * @return  SentimentAnalysisResponse   Returns an instance of SentimentAnalysisResponse class
 * @param  text  The text whose Sentiment has to be analysed
 **/

global class EinsteinService {
    public SentimentAnalysisResponse findSentiment(String text) {
        EinsteinAPI api = new EinsteinApi();        
        SentimentAnalysisResponse resp = api.findSentiment(text);        
        return resp;
    }
}
