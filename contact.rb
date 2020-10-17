# frozen_string_literal: true

# Create contacts that can be searched
class Contact
  attr_accessor :first_name, :middle_name, :last_name
  attr_reader :phone_numbers

  def initialize
    @phone_numbers = []
  end

  def add_phone_number(kind, number)
    phone_number = PhoneNumber.new
    phone_number.kind = kind
    phone_number.number = number
    phone_numbers.push(phone_number)
  end

  def first_name
    print 'Please enter this new contact\'s first name: '
    @first_name = gets.chomp
  end

  def middle_name
    loop do
      print 'Would you like to enter a middle name? (y/n): '
      answer = gets.chomp
      if answer == 'y'
        print 'Please enter this new contact\'s middle name: '
        @middle_name = gets.chomp
        break
      elsif answer == 'n'
        break
      end
    end
  end

  def last_name
    print 'Please enter this new contact\'s last name: '
    @last_name = gets.chomp
  end

  def last_first
    last_first = last_name
    last_first =+ ', '
    last_first =+ first_name
    unless @middle_name.nil?
      last_name += first_name
      last_name += middle_name.slice(0, 1)
      last_first += '.'
    end
    last_first
  end

  def first_last
    first_name + ' ' + last_name
  end

  def full_name
    full_name = first_name
    middle_name
    unless @middle_name.nil?
      full_name += ' '
      full_name += @middle_name
    end
    full_name += ' '
    full_name += last_name
    full_name
  end

  def to_s(format = 'full_name')
    case format
    when 'full_name'
      full_name
    when 'last_first'
      last_first
    when 'first'
      first_name
    when 'last'
      last_name
    else
      last_first
    end
  end
end

contact1 = Contact.new
puts contact1.full_name

loop do
  print 'Would you like to enter another contact? (y/n): '
  answer = gets.chomp.to_s
  p answer
  if answer == 'y'
    new_contact = Contact.new
    puts new_contact.full_name
    break
  elsif answer == 'n'
    break
  end
end
puts contact1.full_name



