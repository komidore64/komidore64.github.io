# font_awesome.rb
#
# Copyright (C) M. Adam Price 2017
#
# usage: {% fa FONT_AWESOME_VECTOR_NAME ... %}
#
require 'shellwords'

module Jekyll

  class FontAwesome < Liquid::Tag
    def initialize(_, argv, _)
      super

      argv = Shellwords.split(argv)

      @parse_opts = {}
      OptionParser.new do |opts|
        opts.on("--style STYLE", "-s STYLE", "Custom styling for font-awesome element") do |style|
          @parse_opts[:style] = style
        end
      end.parse!(argv)

      @fa_classes = argv
      raise 'no font-awesome class given' if @fa_classes.empty?
    end

    def render(_)
      style = (@parse_opts[:style] ? %{ style="#{@parse_opts[:style]}"} : '')
      %{<i class="fa #{@fa_classes.join(" ")}" aria-hidden="true"#{style}></i>}
    end
  end
end

Liquid::Template.register_tag('fa', Jekyll::FontAwesome)
