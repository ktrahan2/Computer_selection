require_relative 'config/environment'

app = Cli.new 

system "clear"
app.store_front
binding.pry


