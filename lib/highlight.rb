require 'redcarpet'
require 'pygmentize'

class Highlight

  def self.highlight(code)
    renderer = PygmentizeHTML
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render(code).gsub("\n", "<br />")
  end
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygmentize.process(code, language)
  end
end
