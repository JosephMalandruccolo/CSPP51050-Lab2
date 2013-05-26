# Joseph Malandruccolo
# Lab 2 - CSPP 51050

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



class ServerBroker < Broker

	




end