/**
 * This class is used to make requests to various Einstein API endpoints.
 * 
 * @author      Jessica Amposta
 * @since       07/16/2019
 * 
 **/

public class EinsteinAPI {
    public String tokenEndpoint {
        get {
            Einstein_API_Settings__c settings =
            		Einstein_API_Settings__c.getInstance(UserInfo.getOrganizationId());
            return settings.Token_Endpoint__c;
        }
    }
    
    public Decimal tokenExpirationSeconds {
        get {
            Einstein_API_Settings__c settings =
            		Einstein_API_Settings__c.getInstance(UserInfo.getOrganizationId());
            return settings.Token_Expiration_Seconds__c;
        }
    }
    
    public String registeredEmail {
        get {
            Einstein_API_Settings__c settings =
            		Einstein_API_Settings__c.getInstance(UserInfo.getOrganizationId());
            return settings.Registered_Email__c;
        }
    }
    
    public String sentimentEndpoint {
        get {
            Einstein_API_Settings__c settings =
            		Einstein_API_Settings__c.getInstance(UserInfo.getOrganizationId());
            return settings.Sentiment_Endpoint__c;
        }
    }
    
    public String sentimentModelId {
        get {
            Einstein_API_Settings__c settings =
            		Einstein_API_Settings__c.getInstance(UserInfo.getOrganizationId());
            return settings.Sentiment_Model_Id__c;
        }
    }
    
     /**
     * This method is used to make a call and retrieve the token endpoint. 
     * 
     * 
     * @return String	Returns the access token of the org.
     * 
     **/
        
    public String getAccessToken() {
        ContentVersion base64Content = [
            SELECT  Title, VersionData
            FROM    ContentVersion
            WHERE   Title = 'einstein_platform'
            OR      Title = 'predictive_services'
            ORDER BY Title
            LIMIT 1
        ];
        
        String keyContents = base64Content.VersionData.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');
        JWT jwt = new JWT('RS256');
        jwt.pkcs8 = keyContents; 
        jwt.iss = 'developer.force.com';
        jwt.sub = registeredEmail;
        jwt.aud = tokenEndpoint;
        jwt.exp = String.valueOf(tokenExpirationSeconds);
        String access_token = JWTBearerFlow.getAccessToken(tokenEndpoint, jwt);
        return access_token;
    }
    
      /**
     * This method is used to make a call to the sentiment endpoint
     * and retrieve the sentimend of the block of text.
     * 
     * 
     * @param	text	The text whose sentiment has to be analyzed.
     * @return	String	Returns an instance of the SentimentAnalysisResponse class.
     * 
     **/
    
    public SentimentAnalysisResponse findSentiment(String text) {
        String key = getAccessToken();        
        Http http = new Http();        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(sentimentEndpoint);
        req.setHeader('Authorization', 'Bearer ' + key);
        req.setHeader('Content-type', 'application/json');        
        String body = '{\"modelId\":\"'+ sentimentModelId + '\",\"document\":\"' + text + '\"}';
        req.setBody(body);        
        HTTPResponse res = http.send(req);        
        SentimentAnalysisResponse resp =
        		(SentimentAnalysisResponse) JSON.deserialize(res.getBody(), SentimentAnalysisResponse.class);
        return resp;
    }
    
}
