module Rainpress

  class Packer
  
    def compress(script, options = {})
    	# remove comments
    	script = remove_comments(script) unless options[:preserveComments]
    	
  		# remove newlines
    	script = remove_newlines(script) unless options[:preserveNewlines]
    	
		  # remove unneeded spaces
     	script = remove_spaces(script) unless options[:preserveSpaces]
    	
		  # replace colours with shorter names
    	script = shorten_colors(script) unless options[:preserveColors]
    	
		  script
		end
  
    # Remove all comments out of the CSS-Document
  	def remove_comments(script)
      input = script
      script = ''
      
      while input.length > 0 do
        pos = input.index("/*");
        
        # No more comments
        if pos == nil
          script += input
          input = '';
        else # Comment beginning at pos
          script += input[0..(pos-1)] if pos > 0 # only append text if there is some
          input = input[(pos+2)..-1]
          # Comment ending at pos
          pos = input.index("*/")
          input = input[(pos+2)..-1]
        end
      end
      
      # return
  		script
  	end

    # Remove all newline characters
  	def remove_newlines(script)
  		script.gsub(/\n|\r/,'')
  	end
  	
    # (a) Turn mutiple Spaces into a single
    # (b) remove spaces around ;:{},
    # (c) remove tabs
    def remove_spaces(script)
  		script = script.gsub(/(\s(\s)+)/, ' ')
      script = script.gsub(/\s*;\s*/,';')
      script = script.gsub(/\s*:\s*/,':')
      script = script.gsub(/\s*\{\s*/,'{')
      script = script.gsub(/\s*\}\s*/,'}')
      script = script.gsub(/\s*,\s*/,',')
      script = script.gsub("\t",'');
  		script
  	end
  	
  	def shorten_colors(script)
  		# TODO ...
  		script
  	end
    
  end
  
end