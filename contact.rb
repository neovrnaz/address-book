# frozen_string_literal: true

require './phone_number'
require './birthday'
# Create contacts that can be searched
class Contact
  attr_accessor :first_name, :middle_name, :last_name
  attr_reader :phone_numbers

  def initialize
    @phone_numbers = []
    @date = []
  end

  def add_birthday(day)
    birthday = Birthday.new
    birthday.day = day
    @date.push(birthday)
  end


  def add_phone_number(kind, number)
    phone_number = PhoneNumber.new
    phone_number.kind = kind
    phone_number.number = number
    phone_numbers.push(phone_number)
  end

  def print_phone_numbers
    puts "Phone Numbers"
    phone_numbers.each { |phone_number| puts phone_number }
  end

  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def last_name
    @last_name
  end

  def last_first
    last_first = last_name
    last_first += ', '
    last_first += first_name
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
    unless @middle_name.nil?
      full_name += ' '
      full_name += middle_name
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

richard = Contact.new
richard.first_name = 'Richard'
richard.middle_name = 'Guy'
richard.last_name = 'Tea'
richard.add_phone_number('Home', '(123)456-7890')
richard.add_phone_number('Cell', '(123)456-7890')
richard.add_birthday('October 3')
richard.print_phone_numbers
