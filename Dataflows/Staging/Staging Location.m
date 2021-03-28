let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Location__c = Source{[Name="Location__c"]}[Data],
    #"Added Address" = Table.AddColumn(Location__c, "Address", each Text.Combine({[Location_Street__c], [Location_City__c], [Location_State__c], [Country__c]}, ", ")),
    #"Added Index" = Table.AddIndexColumn(#"Added Address", "Index", 1, 1, Int64.Type),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Index",{{"Index", type text}}),
    #"Added Custom" = Table.AddColumn(#"Changed Type", "Unique Name", each Text.Combine({[Name], " - ", [Index]}))
in
    #"Added Custom"