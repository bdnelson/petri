module PetriNet
	# Transition
	class Transition < PetriNet::Base
		attr_accessor :id            # Unique ID
		attr_accessor :name          # Human readable name	
		attr_accessor :description   # Description
		attr_reader   :inputs        # Input arcs
		attr_reader   :outputs       # Output arcs

		# Create a new transition.
		def initialize(options = {}, &block)
			@id = next_object_id
			@name = (options[:name] or "Transition#{@id}")
			@description = (options[:description] or "Transition #{@id}")
			@inputs = Array.new
			@outputs = Array.new

			yield self unless block == nil
		end	
		
		# Add an input arc
		def add_input(arc)
			@inputs << arc.id unless arc.nil?
		end
		
		# Add an output arc
		def add_output(arc)
			@outputs << arc.id unless arc.nil?
		end

		# GraphViz ID
		def gv_id
			"T#{@id}"
		end

		# Validate this transition.
		def validate
			return false if @id < 1
			return false if @name.nil? or @name.length < 1
			return true
		end

		# Stringify this transition.
		def to_s
			"#{@id}: #{@name}"
		end

		# GraphViz definition
		def to_gv
			"\t#{self.gv_id} [ label = \"#{@name}\" ];\n"
		end
	end 
end
