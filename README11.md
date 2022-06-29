# SEA stack of dataformats

## abstract

### request
```
turtle triple <-(fuseki)- SPARQL <-(SPARQL.Client)- SPARQL.Query <-(sea_graphql)- (graphql)json <-(phoenix)- Changeset <-- html <-- human
```
### response
```
turtle triple -(fuseki)-> (fuseki)json -(SPARQL.Client)-> %SPARQL.Query.Result{} -(sea_graphql)-> (graphql)json -(phoenix)-> html --> human
```

## stored in fuseki as (turtle) triples
```
<< << <Mushroom> rdfs:subClassOf <Vegetable> >> seaa:eventId "00000000-0000-0000-0002-000000000008" >>
seaa:transactionTime  "2020-01-01T00:00:00+02:00"^^xsd:dateTime ;
seaa:decisionTime     "2020-01-01T00:00:00+02:00"^^xsd:dateTime ;
seaa:validFrom        "2020-01-01T00:00:00+02:00"^^xsd:dateTime ;
seaa:validTo          "2022-01-01T00:00:00+02:00"^^xsd:dateTime ;
seaa:deletionTime     "2021-01-01T00:00:00+02:00"^^xsd:dateTime . # <-- deletion
```

## queried as sparql
```
BASE <http://www.example.org/>
PREFIX : <http://example.org/>
PREFIX seaa: <http://www.seaa.ch/ontologies/2022/5/seaa-statement#>
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX xml: <http://www.w3.org/XML/1998/namespace>

SELECT DISTINCT ?s1 ?s2 ?s3 WHERE {
  BIND(\"2021-07-01T00:00:00+02:00\"^^xsd:dateTime as ?requestTime)

  << << ?s1 rdfs:subClassOf <Vegetable> >> seaa:eventId ?eventId1 >> seaa:deletionTime ?deletionTime1 ;
  																	 seaa:transactionTime ?transactionTime1 .
  FILTER((?deletionTime1 > ?requestTime) && (?transactionTime1 < ?requestTime))

  OPTIONAL{
    << << ?s2 rdfs:subClassOf ?s1 >> seaa:eventId ?eventId2 >>  seaa:deletionTime ?deletionTime2 ;
																seaa:transactionTime ?transactionTime2 .
	FILTER((?deletionTime2 > ?requestTime) && (?transactionTime2 < ?requestTime))

    OPTIONAL{
          << << ?s3 rdfs:subClassOf ?s2 >> seaa:eventId ?eventId3 >>  seaa:deletionTime ?deletionTime3 ;
                                                                      seaa:transactionTime ?transactionTime3 .
    FILTER((?deletionTime3 > ?requestTime) && (?transactionTime3 < ?requestTime))
  	}
  }
}
```

## response from fuseki as json --> transformed to elixir map %SPARQL.Query.Result{}
```
{:ok,
 %SPARQL.Query.Result{
   results: [
     %{
       "object" => %RDF.Literal{literal: %RDF.XSD.DateTime{value: ~U[2021-12-31 22:00:00Z], lexical: "2022-01-01T00:00:00+02:00"}, valid: true},
       "predicate" => ~I<http://www.seaa.ch/ontologies/2022/5/seaa-statement#validTo>,
       "subject" => {{~I<http://www.example.org/Legumes>,
         ~I<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>,
         ~I<http://www.seaa.ch/ontologies/2022/5/seaa-statement#SeaaClass>},
        ~I<http://www.seaa.ch/ontologies/2022/5/seaa-statement#eventId>,
        %RDF.Literal{literal: %RDF.XSD.String{value: "00000000-0000-0000-0002-000000000004", lexical: "00000000-0000-0000-0002-000000000004"}, valid: true}}
     },
     %{
       "object" => %RDF.Literal{literal: %RDF.XSD.DateTime{value: ~U[2021-12-31 22:00:00Z], lexical: "2022-01-01T00:00:00+02:00"}, valid: true},
       ...
     },
     %{...},
     ...
   ],
   variables: ["subject", "predicate", "object"]
 }}
```

## graphql request
```
query {
  countries(
      take: 1,
      skip: 1,
      sort:{
        field:id,
        order:ASC
      }
  ) {
    countries {
      code
      name
    }
  }
}
```

## graphql response
https://countries.trevorblades.com
```
{
  http_status_code: 200
  data: {
    countries: {
      countries: [
        0: {
          code: AFG
          name: Afghanistan
        }
        1: {
          code: IND
          name: India
        }
      ]
    }
  }
}
```

## Changeset
tbd
