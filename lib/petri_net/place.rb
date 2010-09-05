class PetriNet::Place < PetriNet::Base
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
    @inputs << arc.id unless arc.nil?
  end

  # Add an output arc
  def add_output(arc)
    @outputs << arc.id unless arc.nil?
  end

  # GraphViz ID
  def gv_id
    "P#{@id}"
  end

  # Validate the setup of this place.
  def validate
    return false if @id.nil? or @id < 0
    return false if @name.nil? or @name.strip.length <= 0
    return false if @description.nil? or @description.strip.length <= 0
    return false if @capacity.nil? or @capacity <= 0
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