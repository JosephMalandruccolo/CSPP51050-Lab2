require_relative 'string_counters'
require_relative 'proxies'
require_relative 'call_message'
require_relative 'brokers'
require_relative 'client'

# => establish connections between objects in the broker pattern
# => returns a usable client
def setup

	sb = ServerBroker.new
	cb = ClientBroker.new(sb)
	cp = ClientProxy.new(cb)

	Client.new(cp)

end

client = setup
response = client.character_frequency "hello\u0639"

puts response.result