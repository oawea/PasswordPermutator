#!/usr/bin/env ruby
$LOAD_PATH << "."
require 'gen.rb'
include Permutations

def help
  puts "./permscript.rb [passwordfile]"
end


#for now, assume only one password is returned from file reader
def stage objects, reader
  #this is where the fun happens
  objects.each do |obj|
    obj.build_hash
    obj.load_rules
    obj.mutate
    puts obj.write_table.flatten
    #reader.write_out(obj.write_table.flatten) wont work with onjects.each -> obviously overwrites
    #end the fun now!
  end
end

def main path
  puts "welcome to the password permutator!"
  reader = Permutations::FileUtils.new path, :output_file=>"passwords_output"
  mutator_objects = []
  reader.base_list.each {|pass| mutator_objects.push(Permutations::Mutator.new(pass))} 
  stage mutator_objects, reader
end

def parse_opts
  raise ArgumentError, "first argument must be -f [passwordfile]" unless ARGV[0].eql?("-f")
  path = ARGV[1].to_s.chomp
  raise ArgumentError, "password file must exist" unless File.exists?(path)
  main path
end

parse_opts unless ARGV.length === 0
help if ARGV.length === 0
