# lightbox.rb
#
# Copyright (C) M. Adam Price 2016
#
# usage: {% lightbox [OPTIONS] /path/to/image/file.jpg [lightbox group] %}
#
require 'shellwords'

module Jekyll

  class Lightbox < Liquid::Tag

    def initialize(_, argv, _)
      super

      argv = Shellwords.split(argv)

      @parse_opts = {}
      OptionParser.new do |opts|
        opts.on('--title TITLE', '-t TITLE', 'Title caption of image') do |title|
          @parse_opts[:title] = title
        end

        opts.on('--alt ALT', '-a ALT', 'Alternate image text') do |alt|
          @parse_opts[:alt] = alt
        end
      end.parse!(argv)

      # positional args
      @filepath = argv.pop
      raise 'no filepath found' unless @filepath
      @group = argv.pop
      @group ||= filename_of(@filepath)
    end

    def render(_)
      data_title = @parse_opts[:title].nil? ? '' : %Q{ data-title="#{@parse_opts[:title]}"}
      alt = %Q{ alt="#{@parse_opts[:alt].nil? ? @group : @parse_opts[:alt]}"}
      %Q{<a href="#{@filepath}" data-lightbox="#{@group}"#{data_title}><img src="#{@filepath}"#{alt}/></a>}
    end

    private

    def filename_of(filepath)
      filepath.split('/').last
    end

  end
end

Liquid::Template.register_tag('lightbox', Jekyll::Lightbox)
