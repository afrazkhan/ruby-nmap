require 'nmap/task'

require 'rprogram/program'

module Nmap
  #
  # Represents the 'nmap' and 'masscan' programs
  #

  class Program < RProgram::Program

    def self.set_program (program_name)
      program = program_name

      if program == 'masscan'
        name_program 'masscan'
      elsif program == 'nmap'
        name_program 'nmap'
      else
        puts "Please set which program you'd like to use with Nmap::Program.set_program"
      end
    end


    #
    # Finds the `nmap` program and performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @example Specifying Nmap options via a Hash.
    #   Nmap::Program.scan(
    #     :targets => '192.168.1.1',
    #     :ports => [22,80,443],
    #     :verbose => true
    #   )
    #
    # @example Specifying Nmap options via a {Task} object.
    #   Nmap::Program.scan do |nmap|
    #     nmap.targets = '192.168.1.1'
    #     nmap.ports = [22,80,443]
    #     nmap.verbose = true
    #   end
    #
    # @see #scan
    #
    def self.scan(options={},exec_options={},&block)
      find.scan(options,exec_options,&block)
    end

    #
    # Finds the `nmap` program and performs a scan, but runs `nmap` under
    # `sudo`.
    #
    # @see scan
    #
    # @since 0.8.0
    #
    def self.sudo_scan(options={},exec_options={},&block)
      find.sudo_scan(options,exec_options,&block)
    end

    #
    # Performs a scan.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for nmap.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for nmap.
    #
    # @yieldparam [Task] task
    #   The nmap task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see http://rubydoc.info/gems/rprogram/0.3.0/RProgram/Program#run-instance_method
    #   For additional exec-options.
    #
    def scan(options={},exec_options={},&block)
      run_task(Task.new(options,&block),exec_options)
    end

    #
    # Performs a scan and runs `nmap` under `sudo`.
    #
    # @see #scan
    #
    # @since 0.8.0
    #
    def sudo_scan(options={},exec_options={},&block)
      sudo_task(Task.new(options,&block),exec_options)
    end

  end
end
