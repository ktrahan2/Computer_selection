require 'bundler/setup'
require 'colorize'
require 'colorized_string'
Bundler.require
require "tty-prompt"
require_all 'lib'

ActiveRecord::Base.logger = nil

