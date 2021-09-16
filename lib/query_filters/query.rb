require 'forwardable'

module QueryFilters
  class Query
    extend ::Forwardable

    attr_accessor :query_string, :options

    def_delegators :parser, :to_hash, :parse

    def initialize(query_string, options = {})
      @options      = options
      @query_string = query_string
    end

    # @return [QueryFilters::Parser]
    def parser
      Parser.new(self, options)
    end
  end
end
