require './contact'
class AddressBook
  attr_reader :contacts
  def initialize
    @contacts = []
  end

  def print_contact_list
    puts "Contact List: \n"
    puts '-' * 30
    contacts.each do |contact|
      puts contact.to_s('last_first')
    end
  end
end

address_book = AddressBook.new
richard = Contact.new
richard.first_name = 'Richard'
richard.middle_name = 'Guy'
richard.last_name = 'Tea'
richard.add_phone_number('Home', '(123)456-7890')
richard.add_phone_number('Cell', '(123)456-7890')
richard.add_birthday('October 3')
richard.add_address('Home', '123 Main St.', '', 'Portland', 'OR', '12345')

address_book.contacts.push(richard)
address_book.print_contact_list
horizontal_rule
