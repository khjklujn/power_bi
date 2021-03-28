let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Location_Opp__c = Source{[Name="Location_Opp__c"]}[Data]
in
    Location_Opp__c