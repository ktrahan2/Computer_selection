class Cli 

    attr_accessor :dimensions, :function, :price

    def initialize dimensions = nil, function = nil, price = nil
        @dimensions = nil
        @function = nil
        @price = nil
    end
    
    # def store front
    # tty prompt
        #get a computer recommendation
        #returning customers - wishlist
        # refer to a friend
        #if get a compiuter recommendation
            #store_introduction 
        #elsif
            # returning customers




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

    def computer_questions
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
        computer_selection = Computer.where(dimensions: @dimensions, function: @function) #add price whenever figure out how to.
        binding.pry
        puts Ascii.store_name #change later
        puts "Khajiit has listened and chosen:"
        puts computer_selection.computers.map
        # Recommendation.new at the end of this process
        # make.models.pluck(:name).map { |name| puts name}
    end
        
end