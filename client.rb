# Joseph Malandruccolo
# Lab 2 - CSPP 51050

require_relative 'proxies'

class Client

	def initialize client_proxy
		@client_proxy = client_proxy
	end

	def character_frequency str
		@client_proxy.character_frequency str
	end

	def add num1, num2
		@client_proxy.add num1, num2
	end

end