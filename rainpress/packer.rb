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
      
      # make all other things
    	script = do_misc(script) unless options[:skipMisc]
      
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
  		# rgb(50,101,152) to #326598
      script = script.gsub(/rgb\s*\(\s*([0-9,\s]+)\s*\)/) do |match|
        out = '#'
        $1.split(',').each do |num|
          if num.to_i < 16 
            out += '0'
          end
          out += num.to_i.to_s(16) # convert to hex
        end
        out
      end
      # #AABBCC to #ABC, keep if preceed by a '='
      script = script.gsub(/([^\"'=\s])(\s*)#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])/) do |match|
        out = match        
        if ($3.downcase == $4.downcase) and ($5.downcase == $6.downcase) and ($7.downcase == $8.downcase)
          out = $1 + '#' + $3.downcase + $5.downcase + $7.downcase 
        end
        out
      end
      # shorten several names to numbers
      script = script.gsub(/:[\s]*white[\s]*;/, ':#fff;')
      script = script.gsub(/:[\s]*white[\s]*\}/, ':#fff}')
      script = script.gsub(/:[\s]*black[\s]*;/, ':#000;')
      script = script.gsub(/:[\s]*black[\s]*\}/, ':#000}')
      # shotern several numbers to names
      script = script.gsub(/:[\s]*#([fF]00|[fF]{2}0000);/, ':red;')
      script = script.gsub(/:[\s]*#([fF]00|[fF]{2}0000)\}/, ':red}')
      
  		script
    end
  
    def do_misc(script)
      # Replace 0(pt,px,em,%) with 0 but only when preceded by : or a white-space
      script = script.gsub(/([\s:]+)(0)(px|em|%|in|cm|mm|pc|pt|ex)/) do |match|
        match.gsub(/(px|em|%|in|cm|mm|pc|pt|ex)/,'')
      end
      # Replace 0 0 0 0; with 0.
      script = script.gsub(':0 0 0 0;', ':0;')
      script = script.gsub(':0 0 0 0}', ':0}')
      script = script.gsub(':0 0 0;', ':0;')
      script = script.gsub(':0 0 0}', ':0}')
      script = script.gsub(':0 0}', ':0}')
      script = script.gsub(':0 0;', ':0;')
      # Replace background-position:0; with background-position:0 0;
      script = script.gsub('background-position:0;', 'background-position:0 0;');
      # Replace 0.6 to .6, but only when preceded by : or a white-space
      script = script.gsub(/[:\s]0+\.(\d+)/) do |match|
        match.sub('0', '') # only first '0' !!
      end
      # Replace ;;;; with ;
      script = script.gsub(/[;]+/, ';')
      # Replace ;} with }
      script = script.gsub(';}', '}')
      # Replace background-color: with background:
      script = script.gsub('background-color:', 'background:')

      script
    end
    
  end
  
end