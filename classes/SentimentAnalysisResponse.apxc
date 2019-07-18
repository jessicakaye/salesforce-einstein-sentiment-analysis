/**
 * This SentimentAnalysisResponse class is used to receive the 
 * response from the Einstein Sentiment API.
 * The response is a list with probabilities that contain labels and strings in each index.
 * 
 * @author      Jessica Amposta
 * @since       7/16/19
 **/



global class SentimentAnalysisResponse {
    webservice List<Probabilities> probabilities { get; set; } 
    
global class Probabilities {
        webservice String label { get; set; } 
        webservice Double probability { get; set; }
    }
}
