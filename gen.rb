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
  
  def capitolize_first word 
    
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
      @hash = PassUtils.new @word
      @hash.set(word)
    end
    def load_rules
      @rules = MutatorRules.new
    end
    def mutate
      @rules.each do |rule|
        
      end       
    end
  end

  class FileReader
    def initialize path
      fd = File.open(path, "r")
      @base_strings = []
      fd.each_line{|x| @base_strings.push(x.chomp)}
    end
    def base_list
      @base_strings
    end
  end

  class MutatorRules
    def initialize
      @rules = []
    end
  end

  class PassUtils
    def initialize word
      @table = {}
      @organized = {}
      @table[word] = true
    end
    def perm_set base, code, str
      if @organized[base] 
        #@organized will house an array of obj 
        #with key being code 
        #described in def evaluate, and val (arr) being permuated strings        
      else
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
  end
end
