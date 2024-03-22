require_relative 'lib/password_manager'

class CLI
  def initialize
    @password_manager = PasswordManager.new("master_password")
  end

  def run
    loop do
      puts "\nLock It Up"
      puts "1. Add Account"
      puts "2. Retrieve Account"
      puts "3. Exit"
      print "Enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1
        add_account
      when 2
        retrieve_account
      when 3
        puts "Exiting Password Manager..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  private

  def add_account
    print "Enter account name: "
    account_name = gets.chomp
    print "Enter username: "
    username = gets.chomp
    print "Enter password: "
    password = gets.chomp

    @password_manager.add_account(account_name, username, password)
    puts "Account added successfully!"
  end

  def retrieve_account
    print "Enter account name: "
    account_name = gets.chomp

    account = @password_manager.retrieve_account(account_name)
    if account
      puts "Account: #{account_name}"
      puts "Username: #{account[:username]}"
      puts "Password: #{account[:password]}"
    else
      puts "Account not found."
    end
  end
end

CLI.new.run
