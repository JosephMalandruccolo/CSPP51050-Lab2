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

	def call_message_from_byte_stream stream
		# => reverse of the above
	end

end



class ServerBroker < Broker






end