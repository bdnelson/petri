#!/usr/bin/env ruby
#
#

require 'rubygems'
require 'logger'
require "#{`pwd`.strip}/../lib/petri_net"

puts "((Create PetriNet [Water]))"
net = PetriNet::Net.new(:name => 'Water', 
	:description => 'Creation of water from base elements')
net.logger = Logger.new(STDOUT)

puts "((Create Place 1 [Hydrogen]))"
place = PetriNet::Place.new(:name => 'Hydrogen')

puts "((Add Place 1 [Hydrogen] to PetriNet))"
net.add_place(place)

puts "((Add Place 2 [Oxygen] to PetriNet))"
net.add_place(PetriNet::Place.new(:name => 'Oxygen'))

puts "((Add Place 3 [Water] to PetriNet))"
net << PetriNet::Place.new do |p|
	p.name = 'Water'
end

puts "((Add Transition 1 [Join] to PetriNet))"
net.add_transition(PetriNet::Transition.new(:name => 'Join'))

puts "((Add Arc 1 [Hydrogen.Join] to PetriNet))"
net << PetriNet::Arc.new do |a|
	a.name = 'Hydrogen.Join'
	a.weight = 2
	a.add_source(net.objects[net.places['Hydrogen']])
	a.add_destination(net.objects[net.transitions['Join']])
end

puts "((Add Arc 2 [Oxygen.Join] to PetriNet))"
arc = PetriNet::Arc.new do |a| 
	a.name = 'Oxygen.Join'
	a.add_source(net.objects[net.places['Oxygen']])
	a.add_destination(net.objects[net.transitions['Join']])
end
net.add_arc(arc)

puts "((Add Arc 3 [Join.Water] to PetriNet))"
net.add_arc(PetriNet::Arc.new(
		:name => 'Join.Water',
		:description => "Join to Water",
		:source => net.objects[net.transitions["Join"]],
		:destination => net.objects[net.places["Water"]],
		:weight => 1
	)
)

puts
puts
puts net.inspect
puts
puts
puts net.to_s
puts
puts
puts net.to_gv
puts
