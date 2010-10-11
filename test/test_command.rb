# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2009-2010, Sebastian Staudt

require 'test_parameter'

class TestCommand < Test::Unit::TestCase

  include TestParameter

  context 'A Rubikon command' do

    should 'be a Parameter' do
      assert Command.included_modules.include?(Parameter)
      assert Command.new(@sandbox, :command){}.is_a?(Parameter)
    end

    should 'raise an exception when no appliation is given' do
      assert_raise ArgumentError do
        Command.new nil, :command
      end
    end

    should 'raise an exception when no code block is given' do
      assert_raise BlockMissingError do
        Command.new @sandbox, :command
      end
    end

    should 'not raise an exception when created with correct options' do
      description = 'This is a command'
      name        = :command
      assert_nothing_raised do
        command = Command.new @sandbox, name do end
        command.description = description
        assert_equal name, command.name
        assert_equal description, command.description
      end
    end

    should 'correctly parse given parameters' do
      command = Command.new @sandbox, :command, 1 do end
      option = Option.new(@sandbox, :test, 1)
      command.add_param option
      flag = Flag.new(@sandbox, :t)
      command.add_param flag
      command.run(*%w{--test arg -t test})
      assert option.active?
      assert flag.active?
      assert_equal %w{test}, command.arguments
      assert_equal %w{arg}, command.parameters[:test].args

      assert_raise UnknownParameterError do
        command.run(*%w{--unknown})
      end
    end

    should 'allow parameter aliases' do
      command = Command.new @sandbox, :command do end
      flag1 = Flag.new(@sandbox, :test)
      command.add_param flag1
      flag2 = Flag.new(@sandbox, :test2)
      command.add_param flag2
      command.add_param({ :t => :test, :t2 => :test2 })
      command.run(*%w{-t --t2})
      assert flag1.active?
      assert flag2.active?
    end

    should 'run the code supplied inside its block' do
      block_run = false
      command = Command.new @sandbox, :command do
        block_run = true
      end
      command.run
      assert block_run
    end

    should 'run external code if no block is given' do
      @app.external_command_run = false
      command = Command.new @sandbox, :external_command
      command.run
      assert @app.external_command_run
    end

  end

end