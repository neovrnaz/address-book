# frozen_string_literal: true

# Create contacts that can be searched
class Contact
  attr_accessor :first_name, :middle_name, :last_name

  def first_name
    print 'Please enter this new contact\'s first name: '
    @first_name = gets.chomp
  end

  def middle_name
    print 'Would you like to enter a middle name? (y/n): '
    answer = gets.chomp
    loop do
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
      last_name += middle_name.slice(0)
    end
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
end

contact1 = Contact.new
puts contact1.full_name
