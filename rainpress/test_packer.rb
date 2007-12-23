require 'test/unit'
require File.join(File.dirname(__FILE__), 'packer.rb')

module Rainpress
	class TestPacker < Test::Unit::TestCase
		
		# create an instace of Rainpress::Packer for use in the tests
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
      # empty string
      input = ''
      assert_equal('', @packer.remove_comments(input))
		end
		
    # Test Rainpress::Packer.remove_newlines
		def test_remove_newlines
      # plain unix-newline
      input = "\n"
      assert_equal('', @packer.remove_newlines(input))
      # plain windows newline
      input = "\r\n"
      assert_equal('', @packer.remove_newlines(input))
      # no newline
      input = "rn"
      assert_equal('rn', @packer.remove_newlines(input))
      # newlines floatin in text
      input = "sss\n||\r\nsss"
      assert_equal('sss||sss', @packer.remove_newlines(input))
      # empty string
      input = ''
      assert_equal('', @packer.remove_newlines(input))
		end
		
	end
end	