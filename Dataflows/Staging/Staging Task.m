let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Task1 = Source{[Name="Task"]}[Data],
    #"Removed Tasks That Have Not Been Modified For 1 Year" = Table.SelectRows(
        Task1,
        each [LastModifiedDate] > Date.AddYears(DateTime.LocalNow(), -1)
    ),
    #"Removed Null Activity Dates" = Table.SelectRows(#"Removed Tasks That Have Not Been Modified For 1 Year", each ([ActivityDate] <> null)),
    // #"Remove Null Subtypes" = Table.SelectRows(#"Removed Null Activity Dates", each ([Activity_Sub_Type__c] <> null)),
    #"Added Custom Activity Month" = Table.AddColumn(#"Removed Null Activity Dates", "Activity Month", each Date.EndOfMonth([ActivityDate])),
    #"Changed Type Activity Month" = Table.TransformColumnTypes(#"Added Custom Activity Month",{{"Activity Month", type date}})
in
    #"Changed Type Activity Month"