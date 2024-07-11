require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  # access API url
  api_url = "http://api.exchangerate.host/list?access_key=713c0d9a6e084eb13cddc960c3cf6217"

  # Retrieve API data
  data = HTTP.get(api_url).to_s

  # Convert to JSON
  @parse_data = JSON.parse(data)
  
  @currency = @parse_data["currencies"]
  erb(:main)
end

get("/:currency") do
  # access API url
  api_url = "http://api.exchangerate.host/list?access_key=713c0d9a6e084eb13cddc960c3cf6217"

  # Retrieve API data
  data = HTTP.get(api_url).to_s

  # Convert to JSON
  parse_data = JSON.parse(data)
  
  @currency = parse_data["currencies"]
  @money_one = params.fetch("currency")
  erb(:money_one)
end

get("/:currency_one/:currency_two") do
  @money_one = params.fetch("currency_one")
  @money_two = params.fetch("currency_two")

  # access API url
  api_url = "http://api.exchangerate.host/convert?from=#{@money_one}&to=#{@money_two}&amount=1&access_key=713c0d9a6e084eb13cddc960c3cf6217"

  # Retrieve API data
  data = HTTP.get(api_url).to_s

  # Convert to JSON
  parse_data = JSON.parse(data)

  @conversion = parse_data["result"]

  erb(:conversion)
end
