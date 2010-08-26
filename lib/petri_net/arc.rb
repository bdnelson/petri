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
	# Arc
	class Arc < PetriNet::Base
		attr_reader   :id            # Unique ID
		attr_accessor :name          # Human readable name	
		attr_accessor :description   # Description
		attr_accessor :weight        # Arc weight
		attr_reader   :source        # Source object
		attr_reader   :destination   # Destination object

		def initialize(options = {}, &block)
			@id = next_object_id
			@name = (options[:name] or "Arc#{@id}")
			@description = (options[:description] or "Arc #{@id}")
			@weight = (options[:weight] or 1)
			self.add_source(options[:source]) unless options[:source] == nil
			self.add_destination(options[:destination]) unless options[:destination] == nil
			
			yield self unless block == nil
		end	
		
		# Add a source object
		def add_source(object)
			if validate_source_destination(object)
				@source = object
				object.add_output(self)
			else
				raise "Invalid arc source object: #{object.class}"
			end
		end
		
		# Add a destination object
		def add_destination(object)
			if validate_source_destination(object)
				@destination = object
				object.add_input(self)
			else
				raise "Invalid arc destination object: #{object.class}"
			end
		end
		
		# A Petri Net is said to be ordinary if all of its arc weights are 1's.
		# Is this arc ordinary?
		def ordinary?
			@weight == 1
		end

		# Validate this arc.
		def validate
			if @id < 1 then return false end
			if @name == nil or @name.length <= 0 then return false end
			if @weight < 1 then return false end
			if @source == nil or @destination == nil then return false end
			if @source == @destination then return false end
			if @source.class == @destination.class then return false end
			return true
		end

		# Stringify this arc.
		def to_s
			"#{@id}: #{@name} (#{@weight}) #{@source.id} -> #{@destination.id}"
		end

		def to_gv
			"\t#{@source.gv_id} -> #{@destination.gv_id} [ label = \"#{@name}\", headlabel = \"#{@weight}\" ];\n"
		end

		private

		# Validate source or destination object
		def validate_source_destination(object)
			if object == nil then return false end
			if object.class.to_s != "PetriNet::Place" and object.class.to_s != "PetriNet::Transition"
				return false
			end
			if @source != nil and @source.class.to_s == object.class.to_s then return false end
			if @destination != nil and @destination.class.to_s == object.class.to_s then return false end
			return true
		end
	end 
end
