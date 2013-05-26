# Joseph Malandruccolo
# Lab 2 - CSPP 51050

class String_Frequency_Counter

	def new
		raise "Abstract class cannot be instantiated"
	end

	# => abstract method that returns the frequency of a string
	def frequency
		raise "Abstract method must be implemented in subclass"
	end

end



# => class that is capable of counting the frequency of ascii characters in a string
class Ascii_Counter < String_Frequency_Counter

	# => return a hashmap of character frequencies
	def frequency str

		character_counts = Hash.new(0)
		str.each_char do |c|
			character_counts[c] = character_counts[c] + 1
		end		

		character_counts

	end
end


# => class that is capable of counting the frequency of unicode characters
class Unicode_Counter < String_Frequency_Counter

	# => return a hashmap of character frequencies i.e. 104 => 3 is a count of 3
	def frequency str

		character_counts = Hash.new(0)
		str.each_codepoint do |cp|
			character_counts[cp] = character_counts[cp] + 1
		end

		character_counts

	end
	
end