# Salesforce Einstein Sentiment Analysis

   * This repository was created to store the classes and triggers used to auto-populate a field "Sentiment Analysis" 
    based on a "Comments/Suggestion Field" on the CampaignMember object in Salesforce.



## Steps for Implementing Einstein API in Salesforce

1. Sign up for an [Einstein Platform Services Account.](https://metamind.readme.io/docs/what-you-need-to-call-api#section-get-an-einstein-platform-services-account)

2. [Upload the Key](https://metamind.readme.io/docs/upload-your-key) obtained in step 1 into Salesforce Content.

3. Create Remote Site Setting for Einstein APIs (read more [here](https://metamind.readme.io/docs/apex-qs-create-remote-site))

4. Populate Custom Settings

![custom_settings_screenshot](https://raw.githubusercontent.com/last-khajiit/salesforce-einstein-sentiment-analysis/master/img/custom%20settings.png)

5. Create initial classes JWT, JWTBearerFlow, EinsteinService, SentimentAnalysisResponse, & Einstein API in Salesforce Developer.
  
    * JWT & JWTBearerFlow classes obtained originally from https://github.com/salesforceidentity/jwt.

## Adding the Trigger and SentimentAnalysis Class

   * The SentimentAnalysis class contains a future method that updates a given list of Campaign Members with the appropriate 
   Sentiment Analysis.
   * The GetSentimentAnalysis trigger fires the SentimentAnalysis method that updates the Campaign Members.
