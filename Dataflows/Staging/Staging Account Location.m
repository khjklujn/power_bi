let
    Source = Salesforce.Data(
        "https://login.salesforce.com/",
        [ApiVersion=48]
    ),
    Location__c = Source{[Name="Location__c"]}[Data]
in
    Location__c