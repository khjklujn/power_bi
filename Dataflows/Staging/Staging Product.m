let
    Source = Salesforce.Data("https://login.salesforce.com/", [ApiVersion=48]),
    Product2 = Source{[Name="Product2"]}[Data]
in
    Product2