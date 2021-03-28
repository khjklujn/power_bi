let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Opportunity1 = Source{[Name="Opportunity"]}[Data],
    #"Added Custom Close Month" = Table.AddColumn(Opportunity1, "Close Month", each Date.EndOfMonth([CloseDate])),
    #"Changed Type Close Month" = Table.TransformColumnTypes(#"Added Custom Close Month",{{"Close Month", type date}}),
    #"Added Custom Start Month" = Table.AddColumn(#"Changed Type Close Month", "Start Month", each Date.EndOfMonth([Service_Start_Date__c])),
    #"Changed Type Start Month" = Table.TransformColumnTypes(#"Added Custom Start Month",{{"Start Month", type date}}),
    #"Remove Rows With CloseDate More Than 3 Years Old" = Table.SelectRows(#"Changed Type Start Month", each [CloseDate] >= Date.From(Date.AddYears(DateTime.LocalNow(), -3))),
    #"Added Index Column to Provide Unique Names" = Table.AddIndexColumn(#"Remove Rows With CloseDate More Than 3 Years Old", "Index", 1, 1, Int64.Type),
    #"Changed Index Column to Text" = Table.TransformColumnTypes(#"Added Index Column to Provide Unique Names",{{"Index", type text}}),
    #"Added Unique Name" = Table.AddColumn(#"Changed Index Column to Text", "Unique Name", each Text.Combine({[Name], " - ", [Index]}))
in
    #"Added Unique Name"