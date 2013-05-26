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
puts client.character_frequency "hello"

puts client.add 3, 4


#cm = CallMessage.new(CallMessage::ADD, [3,4])
#sa = ServerBroker.new
#bytes = sa.byte_stream_from_call_message cm
#message = sa.call_message_from_byte_stream bytes
#puts message.value