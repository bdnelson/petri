module PetriNet
	# Common structure
	class Base
		# Accepts a logger conforming to the interface of Log4r or the default Ruby 1.8+ Logger class.
		attr_accessor :logger

		# Global object count.
		@@object_count = 0

		# Initialize the base class.
		def initialize(options = {})
			@logger = Logger.new(STDOUT)
			@logger.level = Logger::INFO
		end	

		# Get the next object ID (object count).
		def next_object_id
			@@object_count += 1
		end
	end 
end
