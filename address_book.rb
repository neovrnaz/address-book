# frozen_string_literal: true
require './contact'

# Class to initialize and store all contacts
class AddressBook
  attr_reader :contacts
  def initialize
    @contacts = []
  end

  def run
    loop do
      puts 'Address Book'
      puts 'p: print address book'
      puts 'a: add contact'
      puts 's: search for contact(s)'
      puts 'e: exit'
      print 'Enter your choice: '
      input = gets.chomp.downcase
      case input
      when 'p'
        print_contact_list
      when 'a'
        add_contact
      when 's'
        print 'Enter a search term: '
        search = gets.chomp
        find_by_name(search)
        find_by_phone_number(search)
        find_by_address(search)
      when 'e'
        break
      end
    end
  end

  def add_contact
    contact = Contact.new
    print "\nFirst name: "
    contact.first_name = gets.chomp
    print 'Middle name: '
    contact.middle_name = gets.chomp
    print 'Last name: '
    contact.last_name = gets.chomp

    done = false
    number_exists = false
    address_exists = false
    until done
      unless address_exists || number_exists
        puts "\nAdd a phone number or address?"
        puts 'p: add a phone number'
        puts 'a: add an address'
      end
      if address_exists && address_exists
        puts "Your contact was successfully added!\n"
        break
      elsif number_exists
        puts 'Add an address?'
        puts 'a: add an address'
      elsif address_exists
        puts 'Add a phone number?'
        puts 'p: add a phone number'
      end
      puts 's: skip'
      print 'Enter your choice: '
      response = gets.chomp.downcase
      case response
      when 'p'
        phone = PhoneNumber.new
        print 'What kind of phone number is this? (Work, Cell, Home, etc): '
        phone.kind = gets.chomp
        print 'Phone number: '
        phone.number = gets.chomp
        contact.phone_numbers.push(phone)
        number_exists = true
      when 'a'
        address = Address.new
        print 'Is this a home address or something else? (Work, Home, etc): '
        address.kind = gets.chomp
        print 'Address line 1: '
        address.street_1 = gets.chomp
        print 'Address line 2: '
        address.street_2 = gets.chomp
        print 'City: '
        address.city = gets.chomp
        print 'State: '
        address.state = gets.chomp
        print 'Postal Code: '
        address.postal_code = gets.chomp
        contact.addresses.push(address)
        address_exists = true
      when 's'
        print "\n"
        break
      else
        puts "Option not found: #{response}"
        done = false
      end
    end
    contacts.push(contact)
  end

  def print_contact_list
    puts '-' * 30
    puts "Contact List: \n"
    puts '-' * 30
    contacts.each do |contact|
      puts contact.to_s('last_first')
    end
  end

  def find_by_name(name)
    results = []
    search = name.downcase
    contacts.each do |contact|
      next unless contact.first_name.downcase.include?(search) ||
                  contact.middle_name.downcase.include?(search) ||
                  contact.last_name.downcase.include?(search)

      results.push(contact) unless results.include?(contact)
    end
    print_results("Name search results for \"#{search.capitalize}\":", results)
  end

  def find_by_phone_number(number)
    results = []
    search = number.gsub('-', '')
    contacts.each do |contact|
      contact.phone_numbers.each do |phone_number|
        if phone_number.number.gsub('-', '').include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    print_results("Phone search results for \"#{search}\":", results)
  end

  def find_by_address(query)
    results = []
    search = query.downcase
    contacts.each do |contact|
      contact.addresses.each do |address|
        if address.to_s('long').downcase.include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    print_results("Address search results for \"#{search}\":", results)
  end

  def print_results(search, results)
    puts search
    puts '-' * 30
    puts results
    puts '-' * 30 + "\n"
    puts "#{results.count} results"
    results.each do |contact|
      puts contact.to_s('full_name')
      contact.print_phone_numbers
      contact.print_addresses
      puts "\n"
    end
  end
end


address_book = AddressBook.new
address_book.run
