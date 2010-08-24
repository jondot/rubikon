# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2009-2010, Sebastian Staudt

require 'test_helper'

class FlagTests < Test::Unit::TestCase

  context 'A Rubikon flag' do

    should 'be a Parameter' do
      assert Flag.included_modules.include? Parameter
      assert Flag.new(:test).is_a? Parameter
    end

    should 'call its code block if it is activated' do
      block_run = false
      flag = Flag.new :flag do
        block_run = true
      end
      flag.active!
      assert flag.active?
      assert block_run
    end

  end

end