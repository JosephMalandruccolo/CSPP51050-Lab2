# Joseph Malandruccolo
# Lab 2 - CSPP 51050
require_relative 'string_counters'

# => class that receives a message from a broker and takes indicated action
class ServerProxy

	attr_accessor :ascii_object, :unicode_object

	# => constants
	ASCII_TYPE = "ascii"
	UNICODE_TYPE = "unicode"


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
	def process_broker_message standard_input

		string_type = standard_input[:type]
		string_value = standard_input[:value]

		if string_type.eql? ASCII_TYPE
			response = @ascii_object.frequency string_value

		elsif string_type.eql? UNICODE_TYPE
			response = @unicode_object.frequency string_value

		else
			raise "invalid string type"

		end
		
		response

	end
end