class Cli 

   attr_accessor :dimensions, :function, :price, :user, :name, :age, :email, :final_computer

    def initialize dimensions = nil, function = nil, price = nil, user = nil, name = nil, age = nil, email = nil, final_computer = nil
        @dimensions = nil
        @function = nil
        @price = nil
        @user = nil
        @name = nil
        @age = nil
        @email = nil
        @final_computer = nil
    end
    
   
    def select_name
        puts "What is your full name?"
        @name = gets.chomp
    end

    def select_age
        puts "How old are you?"
        @age = gets.chomp
        if (age != '0') && (age.to_i.to_s != age.strip)
            puts "Please pick a number!"
            select_age
        else
        end
    end

    def select_email
        puts "Whats your email?"
        @email = gets.chomp
    end

    #gets some information from the user and also inputs it into the Customer table
    def store_introduction 
        puts Ascii.store_name 
        puts "Khajiits has computers if you have answers!"
        select_name
        select_age
        select_email
        @user = Customer.create(name: @name, age: @age, email: @email)
        puts "Welcome #{@name}, Khajiit is here to serve."
    end

    def select_dimensions
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Are you looking for a laptop or desktop?"
        @dimensions = gets.chomp.downcase
        if @dimensions == "laptop" || @dimensions == "desktop"
            puts "Awesome we have plenty of #{@dimensions}s"
        else
            puts "Please pick a valid option"
            select_dimensions
        end
    end

    def select_function
        puts Ascii.store_name #change later to khajiit random ascii
        puts "In stock we have komputers efficient in gaming, video editing, web development or web browsing. What do you need?"
        @function = gets.chomp.downcase
        case @function
        when "gaming"
            puts "Fantastic Khajiit loves #{@function}."
        when "video editing"
            puts "Fantastic Khajiit loves #{@function}."
        when "web development"
            puts "Fantastic Khajiit loves #{@function}."
        when "web browsing"
            puts "Fantastic Khajiit loves #{@function}."
        else 
            puts "Please pick a valid option!"
            select_function
        end
    end

    #returns the price user is willing to spend, should repeat select_price if it isnt a valid entry
    def select_price
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Finally, how much are you looking to spend?"
        @price = gets.chomp
        if (@price != '0') && (@price.to_i.to_s != @price.strip)
            puts "Please pick a number!"
            select_price
        else
            puts "Khajiit is pleased!"
        end
    end

    def recommend
        puts "Would you like to add this computer to your recommendations y/n?"
        answer = gets.chomp
        if answer == "y"
            puts "The #{@final_computer[0].brand} computer has been added to your recommendations list."
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: @user.id, number: rand(10** 10))
            puts "Would you like to get another recommendation y/n>"
            answer_three = gets.chomp
            if answer_three == "y"
                computer_selection
            else
                puts "Thanks for visitng Khajiits Komputers. Have a nice day!"
                #return to store front
                #make method to return to store front
            end
        else
            puts "Would you like to get a new recommendation y/n?"
            answer_two = gets.chomp
            if answer_two == "y"
                computer_selection #try to revamp this to start at the select dimensions within computer selection
            else     
                puts "Thanks for visting Khajiits Komputers. Have a nice day!"
            #return to store front
            #make a method to return to the store front
            end
        end
    end

    
        
   #collects information and returns a single computer based off of user input
    def computer_selection
        # store_introduction
        select_dimensions
        select_function
        select_price
        computer_selected = Computer.where(dimensions: @dimensions.capitalize, function: @function) 
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Khajiit has listened and chosen:"
        @final_computer = computer_selected.select do |computer| 
            computer.price <= @price.to_f
        end
        @final_computer.max_by(0) { |x| x.length }
        puts @final_computer[0].brand + " " + @final_computer[0].model
        recommend
    end
       
   
        
end