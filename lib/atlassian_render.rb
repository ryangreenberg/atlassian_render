require 'redcarpet'

class AtlassianRender < Redcarpet::Render::Base

  VERSION = "0.0.1"

  # Block-level calls
  def block_code(code, language)
    "{code}\n#{code.strip}\n{code}\n\n"
  end

  def block_quote(quote)
    "{quote}\n#{quote.strip}\n{quote}\n\n"
  end

  # block_html(raw_html)
  # Not implemented

  def header(text, header_level)
    "h#{header_level}. #{text}\n"
  end

  def hrule
    "----\n"
  end

  def list(contents, list_type)
    "#{contents}"
  end

  def list_item(text, list_type)
    case list_type
    when :ordered
      "# #{text}"
    when :unordered
      "- #{text}"
    end
  end

  def paragraph(text)
    "#{text.strip}\n\n"
  end

  def table(header, body)
    "#{header.gsub(/\|/, '||')}#{body}"
  end

  def table_row(content)
    "| #{content}\n"
  end

  def table_cell(content, alignment)
    "#{content} | "
  end

  # Span-level calls
  # A return value of `nil` will not output any data
  # If the method for a document element is not implemented,
  # the contents of the span will be copied verbatim

  # autolink(link, link_type)
  # Not implemented

  def codespan(code)
    "{{#{code}}}"
  end

  def double_emphasis(text)
    "*#{text}*"
  end

  def emphasis(text)
    "_#{text}_"
  end

  def image(link, title, alt_text)
    "!#{link}!"
  end

  def linebreak
    "\\"
  end

  def link(link, title, content)
    "[#{content}|#{link}]"
  end

  # raw_html(raw_html)
  # Not implemented

  def triple_emphasis(text)
    "_*#{text}*_"
  end

  def strikethrough(text)
    "-#{text}-"
  end

  def superscript(text)
    "^#{text}^"
  end
end