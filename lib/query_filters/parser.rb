require 'active_support/core_ext/hash/deep_merge'
require 'forwardable'

module QueryFilters
  class Parser
    extend ::Forwardable

    DEFAULT_OPTIONS = {
      nesting_separator: ':',
      assignment_separator: '=',
      filters_separator: ',',
      symbolize_keys: true
    }.freeze

    attr_reader :query, :options, :filters

    def_delegator :query, :query_string

    def initialize(query, options = {})
      @query = query
      @options = DEFAULT_OPTIONS.merge(options)
      parse
    end

    # @return [self]
    def parse
      @filters = query_string.split(options[:filters_separator]).map do |filter|
        parse_filter(filter)
      end
      self
    end

    # @return [Hash]
    def to_hash
      filters_hash = {}
      filters.each { |filter| filters_hash.deep_merge!(filter) }
      filters_hash
    end

    private

    # @param filter [String]
    # @return [Hash]
    def parse_filter(filter)
      key, value = split_filter(filter)
      keys = key.split(options[:nesting_separator])

      keys = keys.map(&:to_sym) if options[:symbolize_keys]

      nested_hash_from_array(keys + [value])
    end

    # @return [Array<String>]
    def split_filter(filter)
      filter.split(options[:assignment_separator])
    end

    # @return [Hash]
    def nested_hash_from_array(array)
      if array.size == 1
        array.first
      else
        { array.shift => nested_hash_from_array(array) }
      end
    end
  end
end
