class Cli 

    def store_front

        prompt.select("Choose one option") do |menu|
            # menu.cycle true  # so that selection cycles around when reach top or bottom
            menu.choice "Find Computer", store_introduction
            menu.choice "Wishlist", 2 #wishlist
            menu.choice "Refer to a friend", 3 # desired value
        end
    end

    # def brands
    #     prompt.multi_select("Choose the brands you like: ", brands)
    #     # brands can be an unique array of all the brands in our database 
    #     # .multi_select will always return an array by default populated
    #     # with the names of choices. Can return custom values. 
    # end

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

    # def first_question
    #     puts Ascii.store_name
    #     puts "Are you looking for a laptop or desktop?"
    #     dimension = gets.chomp
    #     puts "Awesome we have plenty of #{dimension}s"
    # end
        
end