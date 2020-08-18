class Cli 

    # could possible create a method that normalize the user input.

   attr_accessor :dimensions, :function, :price

    def initialize dimensions = nil, function = nil, price = nil
        @dimensions = nil
        @function = nil
        @price = nil
    end
    
    #gets some information from the user and also inputs it into the Customer table
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
        Computer.computer_selection
    end


   #collects information and returns a single computer based off of user input
    def computer_selection
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Are you looking for a laptop or desktop?"
        @dimensions = gets.chomp
        puts "Awesome we have plenty of #{@dimensions}s"
        puts Ascii.store_name #change later to khajiit random ascii
        puts "In stock we have komputers efficient in gaming, video editing, programming or web browsing. What do you need?"
        @function = gets.chomp
        puts "Fantastic Khajiit loves #{@function}."
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Finally, how much are you looking to spend?"
        @price = gets.chomp
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Khajiit knows just the one!"
        computer_selected = Computer.where(dimensions: @dimensions.capitalize, function: @function.capitalize) #add price whenever figure out how to.
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Khajiit has listened and chosen:"
        final_computer = computer_selected.select do |computer| 
            computer.price <= @price.to_f
        end
        puts "#{final_computer.pluck(:brand)}" + "#{final_computer.pluck(:model)}"   
        binding.pry
       #the price comparison is returning all of the computers equal to or less then the user input price, maybe we dont want this, try to find a way
            # to set the price selection equal to the closest number
       #would be beneficial to normalize the users input since capitalize doesnt work because most of them have two names. need to capitalize both names
       #need to add in what happens if they dont input the right information 


        # Recommendation.new at the end of this process to create the recommendation link. maybe this can add it to a wishlist. or we reference the
        # recommendation whenever they click on "wishlist"
        
    end
       
   
        
end