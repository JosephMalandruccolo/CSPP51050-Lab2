require_relative 'string_counters'
require_relative 'proxies'
require_relative 'call_message'
require_relative 'brokers'

cm = CallMessage.new
cm.type = CallMessage::ASCII_TYPE
cm.value = "hello"

cb = ClientBroker.new
sb = ServerBroker.new

response_message = cb.transport_call_message_to_broker cm, sb

puts response_message.result