# This code is free software; you can redistribute it and/or modify it under the
# terms of the new BSD License.
#
# Copyright (c) 2009, Sebastian Staudt

class RubikonTestApp < Rubikon::Application

  set :autorun, false
  set :name, 'Rubikon test application'
  set :raise_errors, true

  default do
    'default action'
  end

  action 'input' do
    input 'input'
  end

  action_alias :alias_before, :object_id

  action 'object_id' do
    object_id
  end

  action_alias :alias_after, :object_id

  action 'noarg' do
    'noarg action'
  end

  action 'realnoarg' do ||
  end

  action 'noarg2' do
  end

  action 'number_string', :param_type => [Numeric, String] do |s,n|
  end

  action 'output', :param_type => String do |s|
    puts s
    put s
    putc s[0]
  end

  action 'required' do |what|
    "required argument was #{what}"
  end

  action 'throbber' do
    throbber do
      sleep 1
    end
  end

end
