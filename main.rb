require_relative 'string_counters'
require_relative 'proxies'
require_relative 'call_message'
require_relative 'brokers'

ascii = "hello"
unicode = "hello\u0639"

sb = ServerBroker.new
cb = ClientBroker.new(sb)
cp = ClientProxy.new(cb)
response_message = cp.character_frequency(unicode)


puts response_message.result