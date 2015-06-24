#!/usr/bin/env ruby
$LOAD_PATH << "."
require 'gen.rb'
include Permutations

def help
  puts "./permscript.rb [passwordfile]"
end

def stage objects
  #this is where the fun happens

  #end the fun now!
end

def main path
  puts "welcome to the password permutator!"
  reader = Permutations::FileReader.new path
  mutator_objects = []
  reader.base_list.each {|pass| mutator_objects.push(Permutations::Mutator.new(pass))} 
  stage mutator_objects
end

def parse_opts
  raise ArgumentError, "first argument must be -f [passwordfile]" unless ARGV[0].eql?("-f")
  path = ARGV[1].to_s.chomp
  raise ArgumentError, "password file must exist" unless File.exists?(path)
  main path
end

parse_opts unless ARGV.length === 0
help if ARGV.length === 0
