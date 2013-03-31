#
# Author: Aaron Huang
# Output a p block with pure css ribbon
#
require './plugins/titlecase.rb'
module Jekyll
  RibbonStyle = /\A(warning|info)\z/
  class Ribbonp < Liquid::Block
    @class=:info
    def initialize(tag_name, markup, tokens)
      if markup =~ RibbonStyle
        @class = $1
      end
      super
    end

    def render(context)
      content = paragraphize(super)
      "<p class='info #{@class}'>#{content}</p>"
    end

    def paragraphize(input)
      "#{input.lstrip.rstrip.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}"
    end
  end
end

Liquid::Template.register_tag('ribbonp', Jekyll::Ribbonp)
