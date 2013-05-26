# Joseph Malandruccolo
# Lab 2 - CSPP 51050

# => message capable of being passed between proxies and brokers
class CallMessage

	# => CONSTANTS
	UNICODE_TYPE = "unicode"
	ASCII_TYPE = "ascii"

	TYPE_WHITELIST = [UNICODE_TYPE, ASCII_TYPE]


	# => PROPERTIES
	attr_accessor :value
	attr_reader :type


	def type= t

		raise "CallMessage type property must be whitelisted" unless TYPE_WHITELIST.include? t
		@type = t
		
	end

end