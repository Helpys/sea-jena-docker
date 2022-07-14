# Public GraphQL APIs
https://ivangoncharov.github.io/graphql-apis/


query {
 __type(name: "Query") {
   name
   fields{
     name
   }
 }
}


query {
  continents{
      name
    }
}


{
  __schema {
    queryType {
      name
      fields{
        name
      }
    }
  }
}
