require "minitest/names/version"

module Minitest
  module Names
    class << self
      def test_with_names(names)
        tmp = names.split(',')
        tmp.map {|name| name.strip }
      end
    end

    module NamesExtendedRunnable
      def self.included base
        base.instance_eval do
          def self.run reporter, options = {}
            names = options[:filter]

            filtered_methods = []

            names.each do |name|
              tmp = self.runnable_methods.find_all { |m|
                name === m || name === "#{self}##{m}"
              }
              filtered_methods += tmp
            end

            return if filtered_methods.empty?

            with_info_handler reporter do
              filtered_methods.each do |method_name|
                run_one_method self, method_name, reporter
              end
            end
          end
        end
      end
    end
  end

  def self.plugin_names_options(opts, options)
    opts.on '-N', '--names names', String, 'list test case names separated by commans' do |names|
      options[:names] = names
    end
  end

  def self.plugin_names_init(options)
    return unless names = options[:names]

    # Override Runnable class if names option is set
    Minitest::Runnable.send(:include, Minitest::Names::NamesExtendedRunnable)
    options[:filter] = Minitest::Names.test_with_names(names)
  end
end
