require_relative "model/ascii.rb"

class Cli 

    def store_introduction 
        puts Ascii.store_name 
        puts "Khajiit has komputers if you have answers"
        puts "What is your name?"
        name = gets.chomp
        puts "Welcome #{name}"
    end
        
end