# Creating the Phoenix project
mix phx.new sea_graphql_api --no-html --no-webpack --no-ecto

# Generating the REST endpoints
mix phx.gen.json Store Book books \
title:string isbn:text:unique description:text price:float authors:array:string --no-context --no-schema

# Adding the routes
lib/books_api_web/router.ex:
resources "/books", BookController, except: [:new, :edit]

# Running the App
mix phx.server
# iex -S mix phx.server
Now visit http://localhost:4000

# Interacting with the API
So now use the book URLs and paste it in Postman to start interacting with the books resource.
Try visiting http://localhost:4000/dashboard and a nice system dashboard will show up:
