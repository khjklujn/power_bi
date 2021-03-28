let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Case1 = Source{[Name="Case"]}[Data],
    #"Remove Null Category and Sub Category" = Table.SelectRows(Case1, each ([Category__c] <> null) and ([Sub_Category__c] <> null)),
    #"Added Custom Close Month" = Table.AddColumn(#"Remove Null Category and Sub Category", "Close Month", each Date.EndOfMonth([ClosedDate])),
    #"Changed Type Close Month" = Table.TransformColumnTypes(#"Added Custom Close Month",{{"Close Month", type date}}),
    #"Added Custom Open Month" = Table.AddColumn(#"Changed Type Close Month", "Open Month", each Date.EndOfMonth([CreatedDate])),
    #"Changed Type Open Month" = Table.TransformColumnTypes(#"Added Custom Open Month",{{"Open Month", type date}})
in
    #"Changed Type Open Month"