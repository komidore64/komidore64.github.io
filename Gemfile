source 'https://rubygems.org'

require 'json'
require 'open-uri'

ghpages = JSON.parse(URI.open('https://pages.github.com/versions.json').read)

ruby "~> #{ghpages['ruby']}"

gem 'github-pages', ghpages['github-pages']
gem 'colorize'
