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
  
    #possibly change order of mainmenu to be Find a computer with Khajiit, choose by brand, wishlist
    def store_front
        prompt = TTY::Prompt.new
        main_menu = prompt.select("Choose one option") do |menu|
            # menu.cycle true  # so that selection cycles around when reach top or bottom
            menu.choice "Find a Computer with Khajiit!", 1 #store_introduction
            menu.choice "Wishlist", 2 #wishlist #maybe rename this to recommendations/returning customer recommendations
            menu.choice "Choose by brand", 3 # desired value
        end

        if main_menu == 1
            store_introduction
        elsif main_menu == 2
            wishlist
        elsif main_menu == 3
            brands
        end
    end

    def brands
        prompt = TTY::Prompt.new
        choices = Computer.all.map {|computer| computer.brand}
        chosen = prompt.multi_select("Choose the brands you like: ", choices.uniq)
        puts "Here are the computers we have from those specific brands: "
        for i in 0...chosen.length do
            computer = Computer.where brand: chosen[i]
            puts chosen[i]   
            computer.each do |comp|
                puts comp.model + " " + comp.function + " " + comp.price.to_s
            end
        end
    end
    
    def select_name
        puts "What is your full name?" #.colorize( :blue ).colorize( :background => :green) just testing colors
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
        end
    end

    def select_friends_age
        puts "How old is your friend?"
        @friends_age = gets.chomp
        if (@friends_age != '0') && (@friends_age.to_i.to_s != @friends_age.strip)
            puts "Khajiit can only read ages in numbers!"
            sleep(2)
            select_friends_age
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

    def returning_customer
        puts "Remind Khajiit what your name is?"
        user_name = gets.chomp.downcase
        @user = Customer.find_by name: user_name
        if !@user
            puts "I don't think you have been here before!"
            sleep(2)
            new_customer
        else
            puts "Welcome back! #{@user.name}"
            sleep(1)
            computer_selection
        end
    end

    def new_customer        
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

    #checks if its a returning customer or new customer and either finds that customer or makes a new one. 
    def store_introduction 
        puts Ascii.store_name
        puts "Welcome to Khoosing a Komputer with Khajiit" 
        puts "Is this your first time visiting Khajiit y/n?"
        answer = gets.chomp.downcase
        if answer == "n"
            returning_customer
        elsif answer == "y"
            new_customer
        else
            puts "Please enter y or n"
            sleep(2)
            store_introduction
        end
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

    #the follow methods allow our customers to save their computer recommendation and potentially add another one.

    def new_recommendation
        puts "Would you like to get a new recommendation y/n?"
        answer_two = gets.chomp.downcase
        if answer_two == "y"
            computer_selection 
        elsif answer_two == "n"  
            puts "Thanks for letting Khajiit help you today."
        else
            puts "Please select y or n!"
            new_recommendation
        end
    end

    def additional_recommendation
        puts "Would you like to get another recommendation y/n>"
        answer_three = gets.chomp.downcase
        if answer_three == "y"
            computer_selection
        elsif answer_three == "n"
            puts "Thanks for letting Khajiit help you today."
        else
            puts "Please select y or n!"
            additional_recommendation
        end
    end

    def recommend
        puts "Would you like to add this computer to your recommendations y/n?"
        answer = gets.chomp.downcase
        if answer == "y"
            puts "The #{@final_computer[0].brand} computer has been added to your recommendations list."
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: @user.id, number: rand(10** 10))
            additional_recommendation
        elsif answer == "n"
            new_recommendation
        else
            puts "Please select y or n"
            recommend
        end
    end
  
    #The following methods allow our customer to refer the the computer they found to a friend and creates a new customer if their friend does
    #not exists in our database yet!

    def find_friend_by_name
        puts "What is your friends full name?"
        friend_name = gets.chomp.downcase
        friend_account = Customer.find_by name: friend_name 
        if !friend_account
            puts "I don't think your friend has been here before!"
            sleep(1)
            create_account_for_friend
        else
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: friend_account.id, number: rand(10 ** 10))
            puts "Absolutely wonderful! We'll add that computer to #{friend_name}s recommendations"
            sleep(2)
            store_front
        end
    end

    def create_account_for_friend
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

    def has_friend_visited
        puts "Has your friend visited us before y/n?"
        answer_two = gets.chomp.downcase
        if answer_two == "y"
            find_friend_by_name
        elsif answer_two == "n"
            create_account_for_friend 
        else
            puts "Please select y or n"
            sleep(1)
            has_friend_visited
        end
    end
         
    def refer_to_a_friend
        puts "Would you like to recommend this computer to a friend y/n?"
        answer = gets.chomp.downcase
        if answer == "y"
            has_friend_visited
        elsif answer == "n"
            puts "No worries, Khajiit doesn't have any friends either. Have a good day!"
            sleep(2)
            store_front
        else
            puts "Please select y or n!"
            sleep(1)
            refer_to_a_friend
        end
    end

   #collects information and returns a single computer based off of user input, allows user to save the recommendation and/or refer to a friend
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
        @final_computer.max_by(0) { |x| x.price }
        sleep(2)
        puts @final_computer[0].brand + " " + @final_computer[0].model
      
        recommend
        sleep(2)
        refer_to_a_friend
    end

    #breaks if you enter a name not found, need to fix this
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