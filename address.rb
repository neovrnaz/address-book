class Address
  attr_accessor :kind, :street_1, :street_2, :city, :state, :postal_code

  def to_s(format = 'short')
    address = ''
    case format
    when 'long'
      address += "#{kind}: "
      address += street_1 + "\n"
      address += street + "\n" unless street_2.nil?
      address += "#{city}, #{state}, #{postal_code}"
    when 'short'
      address += "#{kind}: "
      address += street_1
      if street_2
        address += ' ' + street_2
      end
      address += ", #{city}, #{state}, #{postal_code}"
    end
  end
end
