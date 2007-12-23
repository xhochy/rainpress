module Rainpress

  module Packer
  
    def compress(script, options = {})
    	# remove comments
    	script = removeComments(script) unless options[:preserveComments]
    	
		# remove newlines
    	script = removeNewlines(script) unless options[:preserveNewlines]
    	
		# remove unneeded spaces
    	script = removeSpaces(script) unless options[:preserveSpaces]
    	
		# replace colours with shorter names
    	script = shortenColors(script) unless options[:preserveColors]
    	
		script
    end
	
	def removeComments(script)
		# TODO ...
		script
	end
	
	def removeNewlines(script)
		# TODO ...
		script
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