#--
# Copyright (c) 2009, Brian D. Nelson (bdnelson@gmail.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#++

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
			@inputs << arc.id unless arc == nil
		end
		
		# Add an output arc
		def add_output(arc)
			@outputs << arc.id unless arc == nil
		end

		# GraphViz ID
		def gv_id
			"T#{@id}"
		end

		# Validate this transition.
		def validate
			if @id < 1 then return false end
			if @name == nil or @name.length < 1 then return false end
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
