require 'twitter'

name = ''
token = open("/home/jf712/.twitter/#{name}").read.split("\n")

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = token[0]
  config.consumer_secret     = token[1]
  config.access_token        = token[2]
  config.access_token_secret = token[3]
end

client.update("hoe~~~")
