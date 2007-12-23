module Rainpress

  class Packer
  
    def compress(script, options = {})
    	# remove comments
    	script = remove_comments(script) unless options[:preserveComments]
    	
  		# remove newlines
    	script = remove_newlines(script) unless options[:preserveNewlines]
    	
		  # remove unneeded spaces
     	script = removeSpaces(script) unless options[:preserveSpaces]
    	
		  # replace colours with shorter names
    	script = shortenColors(script) unless options[:preserveColors]
    	
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
  	
  	def removeSpaces(script)
  		# TODO ...
  		script
  	end
  	
  	def shortenColors(script)
  		# TODO ...
  		script
  	end
    
  end
  
end