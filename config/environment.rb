require 'bundler/setup'
Bundler.require
require "tty-prompt"

prompt = TTY::Prompt.new

require_all 'lib'