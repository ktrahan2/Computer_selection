# Khajiits Khomputers

An app for finding computer recommendations!

## Table of Contents
[Description]()
[Gifs]()
[Example Code]()
[Technology Used]()
[Setting up for the Application]()
[Main Features]()
[Features in Progress]()
[Contact Information]()

## Description

Khajiits Khomputers is a CLI application that allows a user to register as a customer, and then find recommendations for a new computer based off of their preferences. The user can also access their saved recommendations via their wishlist. Alternatively the user can view all available computers based off the brand. 

## Gifs section for victor


## Example Code

``` 
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
```
``` 
      def store_introduction 
        system "clear"
        puts Ascii.store_name
        puts "Welcome to " +  "Khoosing".colorize( :red ) + " a " + "Komputer".colorize( :red ) +  " with " + "Khajiit".colorize(:red)
        puts " "
        puts "Is this your " + "first time".underline + " visiting Khajiit y/n?"
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
```

## Technology Used

- Activerecord version 6.0
- Sinatra-activerecord version 2.0
- Rake version 13.0
- Sqlite3 version 1.4
- Require_all version 3.0
- TTY-prompt
- Colorize
- TTY-spinner

## Setting up for the application

First you must run

  ``` bundle install ```

Then in order to run the app:

  ``` ruby runner.rb ```

## Main Features

- User can add themselves to a customers list
- User can find a recommended computer based off of their preferences 
- Browse computer choices by Brand
- Save recommendations to Wishlist
- Access Wishlist and remove previous recommendations
- Recommend a computer to a friend and create the friend a customer account 

## Features in Progress

- Clean up redundancy in code
- Save computer recommendations based off brands feature
- Add music

## Contact Information

Created by [Victor Amigo](https://www.linkedin.com/in/victor-amigo-76146115b/) and [Kyle Trahan](https://www.linkedin.com/in/kyle-trahan-8384678b/)

Please contact us with any questions!


