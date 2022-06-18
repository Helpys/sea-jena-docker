#sea_country

mix phx.new sea_country --live

mix phx.gen.live Playground Country countries name:string code:string

 mix phx.gen.release --docker
