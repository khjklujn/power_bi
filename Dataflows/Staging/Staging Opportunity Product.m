let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    OpportunityLineItem = Source{[Name="OpportunityLineItem"]}[Data],
    #"Removed Products That Have Not Been Modified For 4 Years" = Table.SelectRows(
        OpportunityLineItem, 
        each [LastModifiedDate] > Date.AddYears(DateTime.LocalNow(), -4)
    )
in
    #"Removed Products That Have Not Been Modified For 4 Years"