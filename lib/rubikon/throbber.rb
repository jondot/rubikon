# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2009-2010, Sebastian Staudt

module Rubikon

  # A class for displaying and managing throbbers
  #
  # @author Sebastian Staudt
  # @see Application::InstanceMethods#throbber
  # @since 0.2.0
  class Throbber < Thread

    SPINNER = '-\|/'

    # Creates and runs a Throbber that outputs to the given IO stream while the
    # given thread is alive
    #
    # @param [IO] ostream the IO stream the throbber should be written to
    # @param [Thread] thread The thread that should be watched
    # @see Application::InstanceMethods#throbber
    def initialize(ostream, thread)
      proc = Proc.new do |ostream, thread|
          step = 0
          ostream.putc 32
          while thread.alive?
            ostream << "\b#{SPINNER[step].chr}"
            ostream.flush
            step = (step + 1) % 4
            sleep 0.25
          end
        ostream.putc 8
      end

      super { proc.call(ostream, thread) }
    end

  end

end
