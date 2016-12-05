# score.rb
#
# Copyright (C) M. Adam Price 2016
#
# usage: {% score number %}
#
require 'shellwords'
require 'active_support'

module Jekyll

  class Score < Liquid::Tag
    def initialize(_, argv, _)
      super

      argv = Shellwords.split(argv)

      @number = argv.pop
      raise 'no number given' unless @number
    end

    def render(_)
      "__#{::ActiveSupport::NumberHelper.number_to_delimited(@number)}__"
    end
  end

end

Liquid::Template.register_tag('score', Jekyll::Score)
