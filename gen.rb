#!/usr/bin/env
#programmed to take simple list of words
#(such as related to organization, person, etc)
#and perform password permutations on them
#programmed by oawea

module Permutations
  #the following is where the default permutation methods shall go#

  def number_append word, args=[]
    return_array = []
    if args.length > 0
      return_array = DefaultHelperMethods.num_append_custom word
    else
      #default is 1, 11, 12, 13, 2, 21, 22, 23, 3, 31, 32, 33
      initial = ["1","11","12","13","2","21","22","23","3","31","32","33","123"]
      initial.each{|appendant| return_array.push("#{word}#{appendant}")}
    end
    return_array
  end
  def capitolizer word, args=[]
    return_arr = []
    tmp = word
    if args.length > 0 #assuming that there will only be one arg, and the arg is number of letters to cap.
      0.upto(args[0].to_i) do |x|
        a = tmp[x].upcase
        tmp[x] = a
        return_arr.push(tmp)
        tmp = word
      end
    else
      return_arr.push(word.capitalize)
    end
    return_arr
  end
  def add_symbols word, args=[]
    return_arr = []
    syms = ["!", "?"]
    args.each {|x| syms.push(x)} unless args === nil
    syms.each {|x| return_arr.push("#{word}#{x}")}
    return_arr
  end
  #end default permutations#
  #the following are helper methods for the default permutations (such as arg parsing)
  class DefaultHelperMethods
    def initialize args
      @args = args
    end
    def num_append_custom word
      #spruce up in the future. maybe turn args from array into hash, and implement ranges, etc? who knows
      return_array = []
      @args.each {|appendant| return_array.push("#{word}#{appendant}")}
      return_array
    end
  end
  #end helper methods
  class Mutator
    attr_reader :rules, :word, :hash
    def initialize word
      @word = word
    end
    def build_hash
      @util = PassUtils.new @word
      @util.set(word)
    end
    def load_rules
      @rules = MutatorRules.new
    end
    def mutate
      @rules.rules.each do |rule|
        tmparr = @rules.exec_rule rule, @word
        k = tmparr.keys[0]
        tmparr.each_value {|v| @util.perm_set(@word, k, v)}
      end
    end
    def write_table
      tb = @util.org
      array_to_write = []
      tb.each_key do |key|
        tb[key].each {|x| array_to_write.push(x)}
      end
      array_to_write
    end
  end

  class FileUtils
    def initialize path, args={}
      fd = File.open(path, "r")
      @out_path = args[:output_file] if args[:output_file]
      @base_strings = []
      fd.each_line{|x| @base_strings.push(x.chomp)}
    end
    def base_list
      @base_strings
    end
    def write_out arr
      outfd = File.open(@out_path, "w")
      arr.each {|line| outfd.write("#{line}\n")}
      puts "wrote to #{@out_path}"
    end
  end

  class MutatorRules
    def initialize
      @rules = [1,2,3] #defaults. num appender, capitolizer, !? etc adder.
    end
    def rules
      @rules
    end
    def exec_rule rule, word
      ret_val = {}
      case rule
        when 1
          ret_val[rule] = number_append word 
        when 2
          ret_val[rule] = capitolizer word
        when 3
          ret_val[rule] = add_symbols word    
      end
      ret_val
    end
  end

  class PassUtils
    def initialize word
      @table = {}
      @organized = {}
      @table[word] = true
    end
    def perm_set base, code, str
      if @organized[base][code] 
        #@organized will house an array of obj 
        #with key being code 
        #described in def evaluate, and val (arr) being permuated strings        
        @organized[base][code].push(str) 
      else
        @organized[base][code] = []
        @organized[base][code].push(str) 
      end
    end
    def set word
      @table[word] = true
      @organized[word] = []
    end
    def evaluate word, rule
      #code is 1 for numer (pass[123]<--123), 2 for cap, 
    end
    def set? word
      @table[word]
    end
    def org
      @organized
    end
  end
end
