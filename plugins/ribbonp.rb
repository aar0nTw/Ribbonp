#
# Author: Aaron Huang
# Output a p block with pure css ribbon
#
require './plugins/titlecase.rb'

module Jekyll
  RibbonStyleFull = /\A(warning|info)\s+(.+)/i
  RibbonStyle = /\A(warning|info)/i

  class Ribbonp < Liquid::Block
    @class=:info
    def initialize(tag_name, markup, tokens)
      if markup =~ RibbonStyleFull
        @class = $1
        @title = $2.titlecase
      elsif markup =~ RibbonStyleFull
        @title = @class = $1.titlecase
      end
      super
    end

    def render(context)
      content = paragraphize(super)
      "<p class='info #{@class}' data-title='#{@title}'>#{content}</p>"
    end

    def paragraphize(input)
      if(input.kind_of?(Array))
        input = input.map(&:strip).join
        "#{input.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}"
      else
        "#{input.lstrip.rstrip.gsub(/\n\n/, '</p><p>').gsub(/\n/, '<br/>')}"
      end
    end
  end
end

Liquid::Template.register_tag('ribbonp', Jekyll::Ribbonp)
