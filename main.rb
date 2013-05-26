require_relative 'string_counters'


server_one = Ascii_Counter.instance
server_two = Unicode_Counter.instance

ascii_string = "hello"
unicode_string = "hello\u0639"
puts server_one.frequency ascii_string
puts server_two.frequency unicode_string