require 'minitest/autorun'
require 'atlassian_render'

class String
  def strip_leading_whitespace
    self.gsub(/^\s+/, '')
  end
end

class TestAtlassianRender < MiniTest::Unit::TestCase
  def setup
    @markdown = Redcarpet::Markdown.new(AtlassianRender, :tables => true)
  end

  def test_block_code
    markdown_input = <<-EOS
    Lorem ipsum dolor sit amet
    consectetur adipisicing elit
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    {code}
    Lorem ipsum dolor sit amet
    consectetur adipisicing elit
    {code}
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_block_quote
    markdown_input = <<-EOS.strip_leading_whitespace
    > Lorem ipsum dolor sit amet
    > consectetur adipisicing elit
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    {quote}
    Lorem ipsum dolor sit amet
    consectetur adipisicing elit
    {quote}
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_header
    markdown_input = <<-EOS.strip_leading_whitespace
    # Level 1 #
    ## Level 2 ##
    ### Level 3 ###
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    h1. Level 1
    h2. Level 2
    h3. Level 3
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_hrule
    markdown_input = <<-EOS.strip_leading_whitespace
    ***
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    ----
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_unordered_list
    markdown_input = <<-EOS.strip_leading_whitespace
    - Apples
    - Oranges
    - Bananas
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    - Apples
    - Oranges
    - Bananas
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_ordered_list
    markdown_input = <<-EOS.strip_leading_whitespace
    1. Apples
    2. Oranges
    3. Bananas
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    # Apples
    # Oranges
    # Bananas
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_paragraph
    markdown_input = "Lorem ipsum dolor.\n\nSit amet."
    expected_output = "Lorem ipsum dolor.\n\nSit amet."
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_table
    markdown_input = <<-EOS.strip_leading_whitespace
    Fruit   | Weight
    --------|-------
    Apples  | 5 lbs.
    Pears   | 3 lbs.
    Oranges | 4 lbs.
    EOS
    expected_output = <<-EOS.strip_leading_whitespace.strip
    || Fruit || Weight ||
    | Apples | 5 lbs. |
    | Pears | 3 lbs. |
    | Oranges | 4 lbs. |
    EOS

    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_codespan
    markdown_input = 'Lorem ipsum dolor `sit amet` consectetur.'
    expected_output = 'Lorem ipsum dolor {{sit amet}} consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_bold
    markdown_input = 'Lorem ipsum **dolor** sit __amet__ consectetur.'
    expected_output = 'Lorem ipsum *dolor* sit *amet* consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output    
  end
  
  def test_italic
    markdown_input = 'Lorem ipsum _dolor_ sit *amet* consectetur.'
    expected_output = 'Lorem ipsum _dolor_ sit _amet_ consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_bold_italic
    markdown_input = 'Lorem ipsum __*dolor*__ sit **_amet_** consectetur.'
    expected_output = 'Lorem ipsum *_dolor_* sit *_amet_* consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end
  
  def test_images
    markdown_input = 'Lorem ipsum ![dolor](http://sitamet.com) consectetur.'
    expected_output = 'Lorem ipsum !http://sitamet.com! consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_linebreak
    markdown_input = [
      'Lorem ipsum dolor  ',
      'sit amet consectetur.'
    ].join("\n")
    expected_output = 'Lorem ipsum dolor\\sit amet consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_link
    markdown_input = 'Lorem ipsum [dolor](http://sitamet.com) consectetur.'
    expected_output = 'Lorem ipsum [dolor|http://sitamet.com] consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end
  
  def test_raw_html
    markdown_input = 'Lorem ipsum <span>foo</span> consectetur.'
    expected_output = 'Lorem ipsum <span>foo</span> consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_strikethrough
    markdown_input = 'Lorem ipsum -dolor- sit amet consectetur.'
    expected_output = 'Lorem ipsum -dolor- sit amet consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end

  def test_superscript
    markdown_input = 'Lorem ipsum ^dolor^ sit amet consectetur.'
    expected_output = 'Lorem ipsum ^dolor^ sit amet consectetur.'
    actual_output = @markdown.render(markdown_input).strip
    assert_equal actual_output, expected_output
  end
end