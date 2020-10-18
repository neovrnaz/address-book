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
      puts 'e: exit'
      print 'Enter your choice: '
      input = gets.chomp.downcase
      case input
      when 'p'
        print_contact_list
      when 'a'
        add_contact
      when 'e'
        break
      end
    end
  end

  def add_contact
    contact = Contact.new
    print 'First name: '
    contact.first_name = gets.chomp
    print 'Middle name: '
    contact.middle_name = gets.chomp
    print 'Last name: '
    contact.last_name = gets.chomp
    contacts.push(contact)
  end

  def print_results(search, results)
    puts search
    puts '-' * 30
    puts results
    puts '-' * 30 + "\n"
    results.each do |contact|
      puts contact.to_s('full_name')
      contact.print_phone_numbers
      contact.print_addresses
      puts "\n"
    end
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
    print_results("Name search results for \"#{search}\":", results)
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
    print_results("Name search results for \"#{search}\":", results)
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
    print_results("Name search results for \"#{search}\":", results)
  end
end


address_book = AddressBook.new
address_book.run
