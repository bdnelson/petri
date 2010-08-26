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
#
module PetriNet
	# Place
	class Place < PetriNet::Base
		attr_accessor :id            # Unique ID
		attr_accessor :name          # Human readable name	
		attr_accessor :description   # Description
		attr_accessor :capacity      # Token capacity
		attr_reader   :inputs        # Input arcs
		attr_reader   :outputs       # Output arcs

		# Initialize a new place.  Supports block configuration.
		def initialize(options = {}, &block)
			@id = next_object_id
			@name = (options[:name] or "Place#{@id}")
			@description = (options[:description] or "Place #{@id}")
			@capacity = options[:capacity]
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
			"P#{@id}"
		end

		# Validate the setup of this place.
		def validate
			return false unless @id != nil and @id > 0
			return false unless @name != nil and @name.strip.length > 0
			if @description != nil and @description.strip.length <= 0 then return false end
			if @capacity != nil and @capacity <= 0 then return false end
			return true
		end

		# Stringify this place.
		def to_s
			"#{@id}: #{@name} (#{@capacity == nil ? -1 : 0})"
		end

		# GraphViz definition
		def to_gv
			"\t#{self.gv_id} [ label = \"#{@name}\" ];\n"
		end
	end 
end
