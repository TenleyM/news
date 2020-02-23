require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "221adcc1033da8944da11b88bbe93ace"
# url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2078680eea174645b906064f9ae8d13d"
# news = HTTParty.get(url).parsed_response.to_hash


get "/" do
  view "location"
  # show a view that asks for the location
end

get "/news" do
    @location = params["location_field"]
    @location = @location.capitalize

    @results = Geocoder.search(@location)
    @lat_long = @results.first.coordinates
    @forecast = ForecastIO.forecast(@lat_long[0],@lat_long[1]).to_hash
 
    @url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2078680eea174645b906064f9ae8d13d"
    @news = HTTParty.get(@url).parsed_response.to_hash

    view "news"
end