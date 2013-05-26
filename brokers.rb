# Joseph Malandruccolo
# Lab 2 - CSPP 51050

require_relative 'proxies'

# => abstract super class broker
class Broker

	DELIMTER = '|'

	def new
		raise "Cannot instantiate abstract class"
	end

	# => convert a CallMessage to a simulated byte stream
	# => byte stream is simulated by passing an delimited string
	def byte_stream_from_call_message message
		"#{message.type}#{DELIMTER}#{message.value}"
	end


	# => convert a byte stream to a call message object
	def call_message_from_byte_stream stream
		stream_params = stream.split DELIMTER
		cm = CallMessage.new
		cm.type = stream_params[0]
		cm.value = stream_params[1]

		cm

	end

end


# => broker that interacts with the a client broker and server proxy
class ServerBroker < Broker

	def initialize
		@server_proxy = ServerProxy.instance
	end


	# => given a byte stream, forward a call message to the server proxy
	# => the result is a call message with its result attribute set
	def route_call_message_from_byte_stream stream
		@server_proxy.process_broker_message(call_message_from_byte_stream(stream))
	end

end


# => broker that interacts with a client proxy and server broker
class ClientBroker < Broker

	def transport_call_message_to_broker call_message, server_broker
		byte_stream = byte_stream_from_call_message( call_message )
		server_broker.route_call_message_from_byte_stream( byte_stream )
	end

end











