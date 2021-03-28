let
    Source = Excel.Workbook(Web.Contents("https://veristreamnew-my.sharepoint.com/personal/daniel_mcrae_veristream_com/Documents/Business%20Intelligence/Goals.xlsx"), null, true),
    Goals_Sheet = Source{[Item="Goals",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Goals_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Month Id", type date}, {"Owner", type text}, {"Direct Licensing", Int64.Type}, {"Channel Licensing", Int64.Type}, {"Products", Int64.Type}, {"Hosted Supplies", Int64.Type}, {"Professional Services", Int64.Type}}),
    #"Added Custom Close Month" = Table.AddColumn(#"Changed Type", "Close Month", each Date.EndOfMonth([Month Id])),
    #"Changed Type Close Month" = Table.TransformColumnTypes(#"Added Custom Close Month",{{"Close Month", type date}})
in
    #"Changed Type Close Month"