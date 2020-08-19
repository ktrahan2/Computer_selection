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
    #look into cleaning this up? possible to move some functions around so there are less intialized attributes? 
    #does it even matter?
  
    def store_front
        prompt = TTY::Prompt.new
        main_menu = prompt.select("Choose one option") do |menu|
            # menu.cycle true  # so that selection cycles around when reach top or bottom
            menu.choice "Find Computer", 1 #store_introduction
            menu.choice "Wishlist", 2 #wishlist
            menu.choice "Refer to a friend", 3 # desired value
        end

        if main_menu == 1
            store_introduction
        elsif main_menu == 2
            wishlist
        elsif main_menu == 3
            p "Refer to a friend"
        end
    end

    # def brands
    #     prompt.multi_select("Choose the brands you like: ", brands)
    #     # brands can be an unique array of all the brands in our database 
    #     # .multi_select will always return an array by default populated
    #     # with the names of choices. Can return custom values. 
    # end
    
    def select_name
        puts "What is your full name?" #.colorize( :blue ).colorize( :background => :green)
        @name = gets.chomp.downcase
    end

    def select_friends_name
        puts "What is your friends full name?"
        @friends_name = gets.chomp.downcase
    end

    def select_age
        puts "How old are you?"
        @age = gets.chomp
        if (age != '0') && (age.to_i.to_s != age.strip)
            puts "Khajiit can only read ages in numbers!"
            sleep(2)
            select_age
        else
        end
    end

    def select_friends_age
        puts "How old is your friend?"
        @friends_age = gets.chomp
        if (@friends_age != '0') && (@friends_age.to_i.to_s != @friends_age.strip)
            puts "Khajiit can only read ages in numbers!"
            sleep(2)
            select_friends_age
        else
        end
    end
    #could adjust it to make them put in a valid email with @###.com, dont care that much right now.
    def select_email
        puts "Whats your email? Remember your email is case sensitive!"
        @email = gets.chomp
    end

    def select_friends_email
        puts "Whats your friends email? Remember the email is case sensitive!"
        @friends_email = gets.chomp
    end

    #gets some information from the user and also inputs a new row into the Customer table
    def store_introduction 
        puts Ascii.store_name 
        puts "Khajiit has computers if you have answers!"
        select_name
        select_age
        select_email
        @user = Customer.create(name: @name, age: @age, email: @email)
        puts "Welcome #{@name}, Khajiit is here to serve."
        system "clear"
        sleep(2)
        computer_selection
    end

    def select_dimensions
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Are you looking for a laptop or desktop?"
        @dimensions = gets.chomp.downcase
        if @dimensions == "laptop" || @dimensions == "desktop"
            puts "Awesome we have plenty of #{@dimensions}s"
        else
            puts "Please pick either laptop or desktop"
            sleep(2)
            select_dimensions
        end
    end

    def select_function
        puts Ascii.store_name #change later to khajiit random ascii
        puts "In stock we have komputers efficient in gaming, video editing, web development or web browsing. What do you need?"
        @function = gets.chomp.downcase
        case @function
        when "gaming"
            puts "Fantastic Khajiit loves #{@function}. My favorite game is Hello Kitty Island Adventure"
        when "video editing"
            puts "Fantastic Khajiit loves #{@function}."
        when "web development"
            puts "Fantastic Khajiit loves #{@function}."
        when "web browsing"
            puts "Fantastic Khajiit loves #{@function}."
        else 
            puts "Please pick a valid option!"
            sleep(2)
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
            sleep(2)
            select_price
        else
            puts "Rahjin's shadow, Khajiit is pleased!"
        end
    end

    def recommend
        puts "Would you like to add this computer to your recommendations y/n?"
        answer = gets.chomp.downcase
        if answer == "y"
            puts "The #{@final_computer[0].brand} computer has been added to your recommendations list."
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: @user.id, number: rand(10** 10))
            #look into saving Recommendation to @recommendation so you can access it through another method later.
            puts "Would you like to get another recommendation y/n>"
            answer_three = gets.chomp.downcase
            if answer_three == "y"
                computer_selection
            else
                puts "Thanks for visiting Khajiits Komputers. Have a nice day!"
                # store_front
            end
        else
            puts "Would you like to get a new recommendation y/n?"
            answer_two = gets.chomp.downcase
            if answer_two == "y"
                computer_selection 
            else     
                puts "Thanks for visting Khajiits Komputers. Have a nice day!"
                # store_front
            end
        end
    end
    #this method is huge, could be worked down. 
    def refer_to_a_friend
        puts "Would you like to recommend this computer to a friend y/n?"
        answer = gets.chomp.downcase
        if answer == "y"
            puts "Has your friend visited us before y/n?"
            answer_two = gets.chomp.downcase
            if answer_two == "y"
                puts "What is your friends full name?"
                friend_name = gets.chomp.downcase
                friend_account = Customer.find_by name: friend_name 
                Recommendation.create(computer_id: @final_computer[0].id, customer_id: friend_account.id, number: rand(10 ** 10))
                puts "Absolutely wonderful! We'll add that computer to #{friend_name}s recommendations"
                sleep(2)
                store_front
            else
                puts "I will just need a little bit of information about your friend!"
                select_friends_name
                select_friends_age
                select_friends_email
                friend = Customer.create(name: @friends_name, age: @friends_age, email: @friends_email)
                puts "Perfect your friend has been added to our memberslist!"
                Recommendation.create(computer_id: @final_computer[0].id, customer_id: friend.id, number: rand(10 ** 10))
                puts "Wonderful! We'll add that computer to #{@friends_name}s recommendations!"
                sleep(2)
                store_front 
            end
        else
            puts "No worries, Khajiit doesn't have any friends either. Have a good day!"
            store_front
        end
    end



 
   #collects information and returns a single computer based off of user input, allows user to save the recommendation to
   #hopefully be accessed later
    def computer_selection
        #add some type of ascii art
        puts "Time to find out what kind of komputer you are looking for!"
        sleep(2)
        select_dimensions
        select_function
        select_price
        system "clear"
        computer_selected = Computer.where(dimensions: @dimensions.capitalize, function: @function) 
        puts Ascii.store_name #change later to khajiit random ascii
        puts "Khajiit has listened and chosen:"
        @final_computer = computer_selected.select do |computer| 
            computer.price <= @price.to_f
        end
        @final_computer.max_by(0) { |x| x.length }
        sleep(2)
        puts @final_computer[0].brand + " " + @final_computer[0].model
        recommend
        sleep(2)
        refer_to_a_friend
    end

    def wishlist
        puts "Provide your name: "
        name = gets.chomp.downcase
        customer = Customer.find_by name: name
        recommended_computers = customer.computers
        puts "Here are your recommendations!"
        for i in 0...recommended_computers.length do
            puts recommended_computers[i].brand + " " + recommended_computers[i].model
        end
    end

        
end