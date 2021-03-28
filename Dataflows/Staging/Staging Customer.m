let
    Source = Excel.Workbook(Web.Contents("https://veristreamnew-my.sharepoint.com/personal/daniel_mcrae_veristream_com/Documents/Business%20Intelligence/SaasOptics.xlsx"), null, true),
    Customer_Sheet = Source{[Item="Customer",Kind="Sheet"]}[Data],
    #"Changed Type" = Table.TransformColumnTypes(Customer_Sheet,{{"Column1", type text}, {"Column2", type text}}),
    #"Promoted Headers" = Table.PromoteHeaders(#"Changed Type", [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers",{{"SaasOptics ID", type text}, {"Customer Name", type text}}),
    #"Added Index Column to Provide Unique Names" = Table.AddIndexColumn(#"Changed Type1", "Index", 1, 1, Int64.Type),
    #"Changed Index Column to Text" = Table.TransformColumnTypes(#"Added Index Column to Provide Unique Names",{{"Index", type text}}),
    #"Added Unique Name" = Table.AddColumn(#"Changed Index Column to Text", "Unique Name", each Text.Combine({[Customer Name], " - ", [Index]}))
in
    #"Added Unique Name"