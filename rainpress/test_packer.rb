require 'test/unit'
require File.join(File.dirname(__FILE__), 'packer.rb')

module Rainpress
	class TestPacker < Test::Unit::TestCase
		
		def setup
			@packer = Rainpress::Packer.new
		end
		
		# Test Rainpress::Packer.remove_comments
		def test_remove_comments
			# plain comment -> ''
			input = '/* sss */';
			assert_equal('', @packer.remove_comments(input))
			# no comment -> no change
			input = 'sss';
			assert_equal('sss', @packer.remove_comments(input))
			# comment floating in text			 
			input = 's/*ss*/ss';
			assert_equal('sss', @packer.remove_comments(input))			
		end
		
	end
end	