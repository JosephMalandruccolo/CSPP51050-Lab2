require_relative 'string_counters'
require_relative 'proxies'
require_relative 'call_message'
require_relative 'brokers'

cm = CallMessage.new
cm.type = CallMessage::ASCII_TYPE
cm.value = "hello"

sb = ServerBroker.new
puts sb.byte_stream_from_call_message cm
