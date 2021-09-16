require 'minitest/autorun'
require 'query_filters'

class QueryFiltersTest < Minitest::Test
  def test_parsing_with_default_separators
    hash = { date: { gteq: '20-11-2018', lteq: '20-12-2018' } }
    result = QueryFilters.parse('date:gteq=20-11-2018,date:lteq=20-12-2018')

    assert_equal hash, result
  end

  def test_parsing_with_different_separators
    hash = {
      date: { gteq: '20-11-2018', lteq: '20-12-2018' },
      posts: { title: 'what about dogs', order: 'date_desc' }
    }

    result = QueryFilters.parse('date/gteq:20-11-2018;date/lteq:20-12-2018;posts/title:what about dogs;posts/order:date_desc',
      nesting_separator: '/',
      assignment_separator: ':',
      filters_separator: ';'
    )

    assert_equal hash, result
  end

  def test_parsing_without_symbolize_keys
    hash = { 'posts' => { 'title' => 'what about dogs', 'order' => 'title_desc' } }

    result = QueryFilters.parse('posts__title==what about dogs   posts__order==title_desc',
      nesting_separator: '__',
      assignment_separator: '==',
      filters_separator: '   ',
      symbolize_keys: false
    )

    assert_equal hash, result
  end
end
