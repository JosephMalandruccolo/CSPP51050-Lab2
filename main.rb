require_relative 'string_counters'
require_relative 'proxies'

ascii_string = "hello"
unicode_string = "hello\u0639"

standard_message_one = { type: Server_Proxy::ASCII_TYPE, value: "hello" }
standard_message_two = { type: Server_Proxy::UNICODE_TYPE, value: "hello\u0639" }

shared_server_proxy = Server_Proxy.instance
puts shared_server_proxy.process_broker_message standard_message_one
puts shared_server_proxy.process_broker_message standard_message_two