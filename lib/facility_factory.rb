class FacilityFactory
  def create_facilities(state_raw_data)
    state_raw_data.map do |facility|
      facility_details = format_facility(facility)
      Facility.new(
        {
          name:      facility_details[:name],
          address:   facility_details[:address],
          phone:     facility_details[:phone]
        }
      )
    end
  end

  def format_facility(data)
    {
      name:          format_name(data),
      address:       format_address(data),
      phone:         format_phone(data)
    }
  end

  def format_name(data)
    if data[:state] == "NY"
      data[:office_name]
    elsif data[:state] == "MO"
      data[:name].rstrip
    elsif data[:website].include?("ODOT")
      data[:title]
    end
  end

  def format_address(data)
    if data[:state] == "NY"
      "#{data[:street_address_line_1]}, #{data[:city]}, #{data[:state]} #{data[:zip_code]}"
    elsif data[:state] == "MO"
      "#{data[:address1]}, #{data[:city]}, #{data[:state]} #{data[:zipcode]}"
    elsif data[:website].include?("ODOT")
      parsed = JSON.parse(data[:location_1][:human_address], {symbolize_names: true})
      "#{parsed[:address]}, #{parsed[:city]}, #{parsed[:state]} #{parsed[:zip]}"
    end
  end

  def format_phone(data)
    if data[:state] == "NY"
      data[:public_phone_number]
    elsif data[:state] == "MO"
      data[:phone]
    elsif data[:website].include?("ODOT")
      data[:phone_number]
    end
  end
end