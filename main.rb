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

# => test unicode and ascii strings
# => this replaces the str.length method indicated in the instructions
puts client.character_frequency "hello"
puts client.character_frequency "hello\u0639"

# => test numbers of varying digits
puts client.add 3, 4
puts client.add 99, 400
puts client.add 999, 1000