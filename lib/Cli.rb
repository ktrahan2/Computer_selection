class Cli 
  
   attr_accessor :dimensions, :function, :price, :user, :name, :age, :email, :final_computer

    def tty_prompt
        TTY::Prompt.new(

        symbols: { marker: '💻' },
        active_color: :red,
        help_color: :red

        )
    end

    def initialize dimensions = nil, function = nil, price = nil, user = nil, name = nil, age = nil, email = nil, final_computer = nil
        @dimensions = nil
        @function = nil
        @price = nil
        @user = nil
        @name = nil
        @age = nil
        @email = nil
        @final_computer = nil
        @prompt = tty_prompt
    end
  
    def store_front
        puts Ascii.welcome
        puts Ascii.store_name
        main_menu = @prompt.select("Choose one option") do |menu|
            menu.choice "Find a Computer with Khajiit!", 1 
            menu.choice "View by brand", 2 
            menu.choice "Wishlist", 3 
            menu.choice "Exit", 4
        end
        if main_menu == 1
            system "clear"
            store_introduction
        elsif main_menu == 2
            system "clear"
            brands
        elsif main_menu == 3
            system "clear"
            wishlist
        elsif main_menu == 4
            exit
        end
    end

    def brands
        choices = Computer.all.map {|computer| computer.brand}
        chosen = @prompt.multi_select("Choose the brands you like: ", choices.uniq, help: "Scroll with arrows and select with space bar!", show_help: :always, min: 1, filter: true)
        puts "Here are the computers we have available: "
        puts " "
        for i in 0...chosen.length do
            computer = Computer.where brand: chosen[i]
            puts chosen[i].colorize( :green)   
            puts " "
            computer.each do |comp|
                puts comp.model + " " + "for" + " " + comp.function + " " + "at" + " " + "$".colorize(:green) + comp.price.to_s.colorize(:light_red)
            end 
            puts " "
        end
        main_menu = @prompt.select("Where would you like to go next: ") do |menu|
            menu.choice "Find a Computer with Khajiit!", 1
            menu.choice "Wishlist", 2
        end
        if main_menu == 1
            system "clear"
            store_introduction
        elsif main_menu == 2
            system "clear"
            wishlist
        end
    end

    def select_friends
        d = @prompt.collect do
            key(:name).ask("Name?") do |word|
                word.modify :down
            end
          
            key(:age).ask("Age?", convert: :int)

            key(:email).ask("Email?")
        end
        @friends_name = d[:name]
        @friends_age = d[:age]
        @friends_email = d[:email]
    end
    
    def returning_customer
        puts "Remind Khajiit what your name is?"
        user_name = gets.chomp.downcase
        @user = Customer.find_by name: user_name
        if !@user
            puts "I don't think you have been here before!"
            sleep(3)
            system "clear"
            new_customer
        else
            puts " "
            puts "Welcome back! #{@user.name}"
            sleep(3)
            system "clear"
            computer_selection
        end
    end

    def new_customer        
        puts "Khajiit has computers if you have answers!"
        d = @prompt.collect do
            key(:name).ask("Name?")do |word|
            word.modify :down
        end
          
            key(:age).ask("Age?", convert: :int)

            key(:email).ask("Email?")
        end
        @name = d[:name]
        @age = d[:age]
        @email = d[:email]
        @user = Customer.create(name: @name, age: @age, email: @email)
        puts "Welcome #{@name}, Khajiit is here to serve."
        system "clear"
        sleep(3)
        computer_selection
    end

    #checks if its a returning customer or new customer and either finds that customer or makes a new one. 
    def store_introduction 
        puts Ascii.store_name
        puts "Welcome to Khoosing a Komputer with Khajiit" 
        puts " "
        puts "Is this your first time visiting Khajiit y/n?"
        answer = gets.chomp.downcase
        if answer == "n"
            returning_customer
        elsif answer == "y"
            new_customer
        else
            puts "Please enter y or n"
            sleep(3)
            system "clear"
            store_introduction
        end
    end
 
    def select_dimensions
        puts Ascii.select_random
        puts "Are you looking for a laptop or desktop?"
        @dimensions = gets.chomp.downcase
        if @dimensions == "laptop"
            puts Ascii.laptop
            puts "Awesome we have plenty of #{@dimensions}s"
            sleep (2)
            system "clear"
        elsif  @dimensions == "desktop"
            puts Ascii.desktop
            puts "Awesome we have plenty of #{@dimensions}s"
            sleep (2)
            system "clear"
        else
            puts "Please pick either laptop or desktop"
            sleep(2)
            select_dimensions
        end
    end

    def select_function
        puts Ascii.select_random
        puts "In stock we have komputers efficient in gaming, video editing, web development or web browsing. What do you need?"
        @function = gets.chomp.downcase
        case @function
        when "gaming"
            puts Ascii.gaming
            puts "Fantastic Khajiit loves #{@function}. My favorite game is Hello Kitty Island Adventure"
            sleep (4)
            system "clear"
        when "video editing"
            puts Ascii.video_editing
            puts "Fantastic Khajiit loves #{@function}."
            sleep (4)
            system "clear"
        when "web development"
            puts Ascii.web_development
            puts "Fantastic Khajiit loves #{@function}."
            sleep (4)
            system "clear"
        when "web browsing"
            puts Ascii.web_browsing
            puts "Fantastic Khajiit loves #{@function}."
            sleep (4)
            system "clear"
        else 
            puts "Please pick a valid option!"
            sleep(3)
            select_function
        end
    end

    def select_price
 
        puts "Finally, how much are you looking to spend? ($1000 = $1.000)"
        puts " "
        puts Ascii.price
        case @function
        when "gaming"
            @price = @prompt.slider("Price", min: 0.5, max: 2, step: 0.05, format: "|:slider| $ %.3f", show_help: :always)
        when "video editing"
            @price = @prompt.slider("Price", min: 0.7, max: 5, step: 0.05, format: "|:slider| $ %.3f", show_help: :always)
        when "web development"
            @price = @prompt.slider("Price", min: 0.6, max: 2.2, step: 0.05, format: "|:slider| $ %.3f", show_help: :always)
        when "web browsing"
            @price = @prompt.slider("Price", min: 0.3, max: 1, step: 0.05, format: "|:slider| $ %.3f", show_help: :always)
        end
    end

    def additional_recommendation
        puts "Would you like to get another recommendation y/n>"
        answer_three = gets.chomp.downcase
        if answer_three == "y"
            computer_selection
        elsif answer_three == "n"
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
            puts " "
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: @user.id, number: rand(10** 10))
            additional_recommendation
        elsif answer == "n"
            additional_recommendation
        else
            puts "Please select y or n"
            recommend
        end
    end 
  
    #The following methods allow our customer to refer to the computer they found to a friend and creates a new customer if their friend does
    #not exists in our database yet!

    #could just use code from returning customer
    def find_friend_by_name
        puts "What is your friends full name?"
        friend_name = gets.chomp.downcase
        friend_account = Customer.find_by name: friend_name 
        if !friend_account
            puts "I don't think your friend has been here before!"
            sleep(3)
            create_account_for_friend
        else
            Recommendation.create(computer_id: @final_computer[0].id, customer_id: friend_account.id, number: rand(10 ** 10))
            puts "Absolutely wonderful! We'll add that computer to #{friend_name}s recommendations"
            sleep(3)
            store_front
        end
    end
    #could use create customer to get rid of most of this method. 
    def create_account_for_friend
        puts "I will just need a little bit of information about your friend!"
        select_friends
        friend = Customer.create(name: @friends_name, age: @friends_age, email: @friends_email)
        puts "Perfect your friend has been added to our memberslist!"
        Recommendation.create(computer_id: @final_computer[0].id, customer_id: friend.id, number: rand(10 ** 10))
        puts "Wonderful! We'll add that computer to #{@friends_name}'s recommendations!"
        sleep(3)
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
            sleep(3)
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
            sleep(3)
            system "clear"
            store_front
        else
            puts "Please select y or n!"
            sleep(3)
            refer_to_a_friend
        end
    end

   #collects information and returns a single computer based off of user input, allows user to save the recommendation and/or refer to a friend
    def computer_selection
        select_dimensions
        select_function
        select_price
        system  "clear"
        computer_selected = Computer.where(dimensions: @dimensions.capitalize, function: @function) 
        puts Ascii.store_name 
        puts "Khajiit has listened and chosen:"
        @final_computer = computer_selected.select do |computer| 
            computer.price <= (@price.to_f)*1000
        end
        @final_computer.max_by(0) { |x| x.price }
        sleep(2)
        puts " "
        puts @final_computer[0].brand + " " + @final_computer[0].model
        puts " "
        recommend
        sleep(2)
        refer_to_a_friend
    end

    def wishlist
        puts "Provide your" + " " + "name".colorize(:light_red) + " " + "to see your previous recommendations: "
        name = gets.chomp.downcase
        customer = Customer.find_by name: name
        if !customer
            puts "You haven't saved any recommendations yet. Go checkout our amazing computers!"
            store_front
        else
            recommended_computers = customer.computers
            array_brands = Array.new
            for i in 0...recommended_computers.length do
                array_brands << recommended_computers[i].model 
            end
            if array_brands.size == 0
                puts "Sorry, you do not have any saved recommendations yet!"
                puts " "
                store_front
            elsif array_brands.size == 1
                puts "Here are your saved recommendations!"
                puts " "
                puts array_brands
                answer = @prompt.yes?("Would you like to delete this model from your wishlist?")
                if answer == true
                Recommendation.where(customer_id: customer.id).destroy_all
                elsif answer == false
                    puts "Have a good day!"
                end
                puts " "
                puts "Your chosen models have been removed from your wishlist!"
                puts " "
                store_front
            else
                puts "Here are your saved recommendations!"
                puts " "
                puts array_brands
                puts " "
                selected = @prompt.multi_select("Which models would you like to delete from your wishlist?" + " " + "If none hit enter.".colorize(:green), array_brands, help: "Scroll with arrows and select with space bar! Hit enter to finalize.", show_help: :always, min: 0, filter: true)
                selected.each do |select|
                    recommended_computers.each do |computer|
                        if computer.model == select
                            Recommendation.where(customer_id: customer.id, computer_id: computer.id).destroy_all
                        end
                    end
                end
                puts " "
                puts "Your select computers have been removed from your wishlist!"
                sleep(3)
                system "clear"
                store_front
            end
        end
    end

    def exit
        system "clear"
        puts Ascii.thanks
        puts Ascii.store_name
        exit!
    end

end