# Joseph Malandruccolo
# Lab 2 - CSPP 51050
require_relative 'string_counters'
require_relative 'call_message'
require_relative 'integer_adders'

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
		@integer_adder = Adder.new
		
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

		elsif string_type.eql? CallMessage::ADD
			string_value.gsub!('[', '')
			string_value.gsub!(']', '')
			string_value.gsub!(' ', '')
			nums = string_value.split(',')
			call_message.result = @integer_adder.add nums[0], nums[1]
		else
			raise "invalid string type"

		end

		call_message

	end
end


# => class that receives a message from a client and forwards a CallMessage to the client broker
class ClientProxy


	def initialize client_broker
		@client_broker = client_broker
	end


	# => public api
	def character_frequency(str)
		string_type = determine_type str
		call_message = CallMessage.new(string_type, str)
		response_message = @client_broker.invoke_message(call_message)

		response_message.result
		
	end


	def add num1, num2
		data_type = CallMessage::ADD
		nums = [num1, num2]
		call_message = CallMessage.new(data_type, nums)
		response_message = @client_broker.invoke_message(call_message)

		response_message.result

	end


	# => return call message constant for unicode or ascii
	def determine_type str

		encoding_options = {
			:invalid           => :replace,  # Replace invalid byte sequences
    		:undef             => :replace,  # Replace anything not defined in ASCII
    		:replace           => ''        # Use a blank for those replacements
  
		}

		str_without_unicode = str.encode(Encoding.find('ASCII'), encoding_options)

		if str.length == str_without_unicode.length
			return CallMessage::ASCII_TYPE
		else
			return CallMessage::UNICODE_TYPE
		end
	end

end