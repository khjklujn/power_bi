let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Account1 = Source{[Name="Account"]}[Data],
    #"Renamed Columns" = Table.RenameColumns(Account1,{{"SaasOptics_ID__c", "SaasOptics ID"}}),
    #"Added Index Column to Provide Unique Names" = Table.AddIndexColumn(#"Renamed Columns", "Index", 1, 1, Int64.Type),
    #"Changed Index Column to Text" = Table.TransformColumnTypes(#"Added Index Column to Provide Unique Names",{{"Index", type text}}),
    #"Added Unique Name" = Table.AddColumn(#"Changed Index Column to Text", "Unique Name", each Text.Combine({[Name], " - ", [Index]})),
    #"Added Salesforce URL" = Table.AddColumn(#"Added Unique Name", "URL", each Text.Combine({"https://veristream.my.salesforce.com/", [Id]})),
    #"Added Custom" = Table.AddColumn(#"Added Salesforce URL", "URL Name", each "SF")
in
    #"Added Custom"