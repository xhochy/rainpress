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
        :preserveColors => true,
        :skipMisc => true
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
        :preserveColors => true,
        :skipMisc => true
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
        :preserveColors => true,
        :skipMisc => true
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
  
    def test_do_misc
      options = {
        :preserveComments => true,
        :preserveNewlines => true,
        :preserveSpaces => true,
        :preserveColors => true,
        :skipMisc => false
      }  
      # Replace 0(pt,px,em,%) with 0
      input = ' 0px'
      assert_equal(' 0', @packer.compress(input, options))
      input = ' 0em'
      assert_equal(' 0', @packer.compress(input, options))
      input = ' 0pt'
      assert_equal(' 0', @packer.compress(input, options))
      input = ' 0%'
      assert_equal(' 0', @packer.compress(input, options))
      input = ' 0in'
      assert_equal(' 0', @packer.compress(input, options))
      input = ' 0cm '
      assert_equal(' 0 ', @packer.compress(input, options))
      input = ':0mm'
      assert_equal(':0', @packer.compress(input, options))
      input = ' 0pc'
      assert_equal(' 0', @packer.compress(input, options))
      input = '  0ex'
      assert_equal('  0', @packer.compress(input, options))
      input = ' 10ex'
      assert_equal(' 10ex', @packer.compress(input, options))
      
      # Replace 0 0 0 0; with 0.
      input = ':0 0;'
      assert_equal(':0;', @packer.compress(input, options))
      input = ':0 0 0;'
      assert_equal(':0;', @packer.compress(input, options))
      input = ':0 0 0 0;'
      assert_equal(':0;', @packer.compress(input, options))
      # Keep 'background-position:0 0;' !!
      input = 'background-position:0 0;'
      assert_equal('background-position:0 0;', @packer.compress(input, options))
      
      # Replace 0.6 to .6, but only when preceded by : or a white-space
      input = ' 0.6'
      assert_equal(' .6', @packer.compress(input, options))
      input = ':0.06'
      assert_equal(':.06', @packer.compress(input, options))
      input = '10.6'
      assert_equal('10.6', @packer.compress(input, options))
    end
		
	end
end	