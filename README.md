# `atlassian_render` #

This gem provides a subclass of `Redcarpet::Render::Base` that can be used to output Markdown-formatted text in Atlassian's wiki syntax.

## Usage ##

To use this gem in your Ruby code, provide it as the specified renderer when instantiating `Redcarpet::Markdown`.

    require 'redcarpet'
    require 'atlassian_render'
    markdown = Redcarpet::Markdown.new(AtlassianRender::Render)
    markdown.render( <your_markdown_formatted_text> )

Since AtlassianRender depends on Redcarpet, you technically don't have to write `require redcarpet` before using it, but it would be more clear if you did.

The gem also includes the command `markdown2atlassian` that can do conversion on the command line, either by providing a file or by piping input to the command:

    markdown2atlassian <my_file>
    cat some_file | markdown2atlassian

## Example ##

Input document `document.md`:

    # My Document #
    ## Section One ##
    
    - Apples
    - Pears
    - Oranges
    
    ## Section Two ##
    
    Lorem ipsum dolor _sit amet_, consectetur *adipisicing elit*, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad `minim veniam`, quis nostrud _*exercitation ullamco*_ laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    
    function praesent(eget, lectus, nisl) {
      volutpat(eleifend);
      ac (rutrumOdio) {
        namRhoncus = 'tempor velit eget vehicula';
      } velit {
        rutrumLacus = 'primis in faucibus orci';
      }
    }

    > Donec sapien sem, porta sit amet posuere in, dictum et tellus.
    > Etiam condimentum massa at nisl congue euismod. Proin pulvinar
    > ultricies mollis. Lorem ipsum dolor sit amet, consectetur
    > adipiscing elit. Sed turpis lectus, consequat non congue vitae.

Conversion:

    require 'redcarpet'
    require 'atlassian_render'

    markdown = Redcarpet::Markdown.new(AtlassianRender)
    puts markdown.render(File.read('document.md'))

Output:
    
    h1. My Document
    h2. Section One
    - Apples
    - Pears
    - Oranges

    h2. Section Two
    Lorem ipsum dolor _sit amet_, consectetur _adipisicing elit_, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad {{minim veniam}}, quis nostrud __exercitation ullamco__ laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

    {code}
    function praesent(eget, lectus, nisl) {
      volutpat(eleifend);
      ac (rutrumOdio) {
        namRhoncus = 'tempor velit eget vehicula';
      } velit {
        rutrumLacus = 'primis in faucibus orci';
      }
    }
    {code}

    {quote}
    Donec sapien sem, porta sit amet posuere in, dictum et tellus.
    Etiam condimentum massa at nisl congue euismod. Proin pulvinar
    ultricies mollis. Lorem ipsum dolor sit amet, consectetur
    adipiscing elit. Sed turpis lectus, consequat non congue vitae.
    {quote}
    
## Known Issues ##

- **No output for inline HTML.** Markdown supports inline HTML. Atlassian's syntax does not.
- **Nested lists aren't nested.** It doesn't seem like Redcarpet provides the renderer with sufficient information to transform lists to the Atlassian format, which uses extra bullet point markers for each level of indentation.