class Facility
  attr_reader :name,
              :address,
              :phone,
              :services
  attr_accessor :registered_vehicles,
                :collected_fees

  def initialize(facility_details)
    @name                 = facility_details[:name]
    @address              = facility_details[:address]
    @phone                = facility_details[:phone]
    @services             = []
    @registered_vehicles  = []
    @collected_fees       = 0
  end

  def add_service(service)
    @services << service
  end

    def register_vehicle(vehicle)
    if @services.include?("Vehicle Registration")
      collect_fees(vehicle)
      set_plate_type(vehicle)
      set_registration_date(vehicle)
      @registered_vehicles << vehicle
    end
  end

  def collect_fees(vehicle)
    if vehicle.antique?
      @collected_fees += 25
    elsif vehicle.electric_vehicle?
      @collected_fees += 200
    else
      @collected_fees += 100
    end
  end

  def set_registration_date(vehicle)
    vehicle.registration_date = Date.today
  end

  def set_plate_type(vehicle)
    if vehicle.antique?
      vehicle.plate_type = :antique
    elsif vehicle.electric_vehicle?
      vehicle.plate_type = :ev
    else
      vehicle.plate_type = :regular
    end
  end

  def administer_written_test(registrant)
    if @services.include?("Written Test") && registrant.permit? && registrant.age >= 16
      registrant.license_data[:written] = true
    else
      false
    end
  end

  def administer_road_test(registrant)
    if @services.include?("Road Test") && registrant.license_data[:written] == true
      registrant.license_data[:license] = true
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?("Renew License") && registrant.license_data[:written] == true && registrant.license_data[:license] == true
      registrant.license_data[:renewed] = true
    else
      false
    end
  end
end
