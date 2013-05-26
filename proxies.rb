# Joseph Malandruccolo
# Lab 2 - CSPP 51050
require_relative 'string_counters'
require_relative 'call_message'

# => class that receives a message from a broker and takes indicated action
class ServerProxy

	# => singleton code & initialization
	def self.instance
		@@shared_instance ||= new
	end

	private_class_method :new

	def initialize

		@ascii_object = AsciiCounter.new
		@unicode_object = UnicodeCounter.new
		
	end


	# => public api
	# => process the broker's message by choosing the correct server to process the request
	def process_broker_message call_message

		string_type = call_message.type
		string_value = call_message.value

		if string_type.eql? CallMessage::ASCII_TYPE
			call_message.result = @ascii_object.frequency string_value

		elsif string_type.eql? CallMessage::UNICODE_TYPE
			call_message.result = @unicode_object.frequency string_value

		else
			raise "invalid string type"

		end

		call_message

	end
end


# => class that receives a message from a client and forwards a CallMessage to the client broker
class ClientProxy

	# => singleton code & initialization
	def self.instance
		@@shared_instance ||= new
	end

	private_class_method :new

	

end



