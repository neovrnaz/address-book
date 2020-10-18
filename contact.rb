# frozen_string_literal: true

require './address'
require './phone_number'
require './birthday'

# Provides formatting for all contact details
class Contact
  attr_accessor :first_name, :middle_name, :last_name
  attr_reader :phone_numbers, :birthdays, :addresses

  def initialize
    @phone_numbers = []
    @addresses = []
    @date = []
    @birthdays = []
  end

  def add_phone_number(kind, number)
    phone_number = PhoneNumber.new
    phone_number.kind = kind
    phone_number.number = number
    phone_numbers.push(phone_number)
  end

  def add_birthday(day)
    birthday = Birthday.new
    birthday.day = day
    birthdays.push(birthday)
  end

  def add_address(kind, street_1, street_2, city, state, postal_code)
    address = Address.new
    address.kind = kind
    address.street_1 = street_1
    address.street_2 = street_2
    address.city = city
    address.state = state
    address.postal_code = postal_code
    addresses.push(address)
  end

  def print_phone_numbers
    puts 'Phone Numbers:'
    phone_numbers.each { |phone_number| puts phone_number }
  end

  def print_addresses
    puts 'Addresses:'
    addresses.each { |address| print address.to_s('long') }
  end

  def print_birthday
    print 'Birthday: '
    birthdays.each { |birthday| puts birthday }
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
      last_first += ' '
      last_first += middle_name.slice(0, 1)
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

def horizontal_rule
  puts '-' * 30
end
