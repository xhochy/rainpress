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
      options = {
        :preserveComments => false,
        :preserveNewlines => true,
        :preserveSpaces => true,
        :preserveColors => true
      }  
			# plain comment -> ''
			input = '/* sss */';
			assert_equal('', @packer.compress(input, options))
			# no comment -> no change
			input = 'sss';
			assert_equal('sss', @packer.compress(input, options))
			# comment floating in text			 
			input = 's/*ss*/ss';
			assert_equal('sss', @packer.compress(input, options))			
      # empty string
      input = ''
      assert_equal('', @packer.compress(input, options))
		end
		
    # Test Rainpress::Packer.remove_newlines
		def test_remove_newlines
      options = {
        :preserveComments => true,
        :preserveNewlines => false,
        :preserveSpaces => true,
        :preserveColors => true
      }  
      # plain unix-newline
      input = "\n"
      assert_equal('', @packer.compress(input, options))
      # plain windows newline
      input = "\r\n"
      assert_equal('', @packer.compress(input, options))
      # no newline
      input = "rn"
      assert_equal('rn', @packer.compress(input, options))
      # newlines floatin in text
      input = "sss\n||\r\nsss"
      assert_equal('sss||sss', @packer.compress(input, options))
      # empty string
      input = ''
      assert_equal('', @packer.compress(input, options))
		end
    
    def test_remove_spaces
      options = {
        :preserveComments => true,
        :preserveNewlines => true,
        :preserveSpaces => false,
        :preserveColors => true
      }  
      # (a) Turn mutiple Spaces into a single, but not less
      input = '  ' # 2 spaces
      assert_equal(' ', @packer.compress(input, options))
      input = '   ' # 3 spaces
      assert_equal(' ', @packer.compress(input, options))
      # (b) remove spaces around ;:{},
      input = ' ; '
      assert_equal(';', @packer.compress(input, options))
      input = ' : '
      assert_equal(':', @packer.compress(input, options))
      input = ' { '
      assert_equal('{', @packer.compress(input, options))
      input = ' } '
      assert_equal('}', @packer.compress(input, options))
      input = ' , '
      assert_equal(',', @packer.compress(input, options))
      # (c) remove tabs
      input = "\t"
      assert_equal('', @packer.compress(input, options))
    end
		
	end
end	