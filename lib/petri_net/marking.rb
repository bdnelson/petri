module PetriNet
	# Marking
	class Marking < PetriNet::Base
		attr_accessor :id            # Unique ID
		attr_accessor :name          # Human readable name	
		attr_accessor :description   # Description
		attr_accessor :timestep      # Marking timestep

		# Create a new marking.
		def initialize(options = {}, &block)
		  
			yield self unless block == nil
		end	

		# Validate this marking.
		def validate
		end

		# Stringify this marking.
		def to_s
		end
	end 
end
