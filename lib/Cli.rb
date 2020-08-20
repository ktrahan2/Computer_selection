class Cli 
  
   attr_accessor :dimensions, :function, :price, :user, :name, :age, :email, :final_computer

    def tty_prompt
        # help_color = Pastel.new.italic.bright_yellow.detach
        TTY::Prompt.new(
        symbols: { marker: '>' },
        active_color: :cyan,
        help_color: :bright_cyan
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
    #look into cleaning this up? possible to move some functions around so there are less intialized attributes? 
    #does it even matter?
  
    def store_front
        main_menu = @prompt.select("Choose one option") do |menu|
            # menu.cycle true  # so that selection cycles around when reach top or bottom
            menu.choice "Find Computer", 1 #store_introduction
            menu.choice "Wishlist", 2 #wishlist
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
        choices = Computer.all.map {|computer| computer.brand}
        chosen = @prompt.multi_select("Choose the brands you like: ", choices.uniq, help: "Scroll with arrows and select with space bar!", show_help: :always, min: 1, filter: true)
        puts "Here are the computers we have from those specific brands: "
        for i in 0...chosen.length do
            computer = Computer.where brand: chosen[i]
            # binding.pry
            puts chosen[i]   
            computer.each do |comp|
                puts comp.model + " " + comp.function + " " + comp.price.to_s
            end
        end
        main_menu = @prompt.select("Choose where you want to go back: ") do |menu|
            menu.choice "Find Computer", 1
            menu.choice "Wishlist", 2
        end
        if main_menu == 1
            store_introduction
        elsif main_menu == 2
            wishlist
        end
    end
    
    # def select_name
    #     puts "What is your full name?" #.colorize( :blue ).colorize( :background => :green)
    #     @name = gets.chomp.downcase
    # end

    # def select_age
    #     puts "How old are you?"
    #     @age = gets.chomp
    #     if (age != '0') && (age.to_i.to_s != age.strip)
    #         puts "Khajiit can only read ages in numbers!"
    #         sleep(2)
    #         select_age
    #     else
    #     end
    # end

    # #could adjust it to make them put in a valid email with @###.com, dont care that much right now.
    # def select_email
    #     puts "Whats your email? Remember your email is case sensitive!"
    #     @email = gets.chomp
    # end

    #gets some information from the user and also inputs a new row into the Customer table
    def store_introduction 
        puts Ascii.store_name 
        puts "Khajiit has computers if you have answers!"
        # select_name
        # select_age
        # select_email
        d = @prompt.collect do
            key(:name).ask("Name?")
          
            key(:age).ask("Age?", convert: :int)

            key(:email).ask("Email?")
        end
        @name = d[:name]
        @age = d[:age]
        @email = d[:email]
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
        puts "Finally, how much are you looking to spend? ($1000 = $1.000)"
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
        # # if (@price != '0') && (@price.to_i.to_s != @price.strip)
        # #     puts "Please pick a number!"
        # #     sleep(2)
        # #     select_price
        # # else
        #     puts "Rahjin's shadow, Khajiit is pleased!"
        # end
    end

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
            computer.price <= (@price.to_f)*1000
            #binding.pry
        end
        @final_computer.max_by { |x| x.price }
        sleep(2)
        puts @final_computer[0].brand + " " + @final_computer[0].model
        binding.pry
        recommend
    end

    def wishlist
        puts "Provide your name: "
        name = gets.chomp.downcase
        customer = Customer.find_by name: name
        if !customer
            puts "You haven't saved any recommendations yet. Go checkout our amazing computers!"
            store_front
        else
            recommended_computers = customer.computers
            puts "Here are your recommendations!"
            array_brands = Array.new
            for i in 0...recommended_computers.length do
                array_brands << recommended_computers[i]
            end
            binding.pry
            @prompt.multi_select("Choose the brands you like: ", array_brands, help: "Scroll with arrows and select with space bar!", show_help: :always, min: 1, filter: true)
        end
        # binding.pry
    end
        
end