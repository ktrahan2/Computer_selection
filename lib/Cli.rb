class Cli 

    def store_introduction 
        puts Ascii.store_name 
        puts "Khajiits has computers if you have answers!"
        puts "What is your full name?"
        name = gets.chomp
        puts "How old are you?"
        age = gets.chomp
        puts "Whats your email?"
        email = gets.chomp
        Customer.create(name: name, age: age, email: email)
        puts "Welcome #{name}, Khajiit is here to serve."
    end

    def first_question
        puts Ascii.store_name
        puts "Are you looking for a laptop or desktop?"
        dimension = gets.chomp
        puts "Awesome we have plenty of #{dimension}s"
    end
        
end