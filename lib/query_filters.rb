require 'query_filters/version'

require 'query_filters/parser'
require 'query_filters/query'

module QueryFilters
  class ParseError < StandardError; end

  # @param query [String]
  # @param options [Hash]
  # @return [Hash]
  def self.parse(query, options = {})
    Query.new(query, options).to_hash
  end
end
