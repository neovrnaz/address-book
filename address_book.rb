require './contact'

# Class to initialize and store all contacts
class AddressBook
  attr_reader :contacts
  def initialize
    @contacts = []
  end

  def print_results(search, results)
    puts search
    puts "-" * 30
    puts results
    puts "-" * 30 + "\n"
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
richard = Contact.new
richard.first_name = 'Richard'
richard.middle_name = 'Guy'
richard.last_name = 'Tea'
richard.add_phone_number('Home', '202-555-0180')
richard.add_phone_number('Cell', '202-555-0193')
richard.add_birthday('October 3')
richard.add_address('Home', '123 Main St.', '', 'Portland', 'OR', '12345')

russel = Contact.new
russel.first_name = 'Russel'
russel.middle_name = ''
russel.last_name = 'Sprout'
russel.add_phone_number('Cell', '202-555-0750')
russel.add_birthday('March 21')
russel.add_address('Work', '4908 Moonlight Drive.', '', 'Palermo', 'NJ', '08230')

address_book.contacts.push(richard)
address_book.contacts.push(russel)

address_book.find_by_address('4908')
