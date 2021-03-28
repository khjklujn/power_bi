let
    Source = Excel.Workbook(Web.Contents("https://veristreamnew-my.sharepoint.com/personal/daniel_mcrae_veristream_com/Documents/Business%20Intelligence/Staging%20Expected%20Renewals.xlsx"), null, true),
    #"Staging Expected Renewals_Sheet" = Source{[Item="Staging Expected Renewals",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Staging Expected Renewals_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"SaasOptics ID", type text}, {"Customer Name", type text}, {"No of Loc", Int64.Type}, {"Service ARR", type number}, {"ARR Total", type number}, {"MRR Total", type number}, {"Product", type text}, {"Year", type date}}),
    #"Added Custom Close Month" = Table.AddColumn(#"Changed Type", "Close Month", each Date.EndOfMonth([Year])),
    #"Changed Type Close Month" = Table.TransformColumnTypes(#"Added Custom Close Month",{{"Close Month", type date}})
in
    #"Changed Type Close Month"