enable :sessions
use Rack::Flash

get '/' do
  # Look in app/views/index.erb
  api_result = RestClient.get 'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=Stack%20Overflow'
  jhash = JSON.parse(api_result)
  keys = jhash['query']['pages'].keys
  title = jhash['query']['pages'][keys[0]]['title']
  text =  jhash['query']['pages'][keys[0]]['extract']
  text_hash = text.split(' ')
  erb :index, :locals => {results: jhash, title: title}
end

