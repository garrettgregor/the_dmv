require 'spec_helper'
require "./lib/facility"
require "./lib/vehicle"
require "./lib/registrant"

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('Albany DMV Office')
      expect(@facility.address).to eq('2242 Santiam Hwy SE Albany OR 97321')
      expect(@facility.phone).to eq('541-967-2014')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe "Iteration 2" do
    context "facility" do
      it "can register vehicles" do
        facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
        facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
        camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
        
        facility_1.add_service("Vehicle Registration")
        expect(facility_1.services).to eq(["Vehicle Registration"])
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
        expect(cruz.registration_date).to eq(nil)
        
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(cruz.registration_date).to eq(Date.today)
      end
    
      it "can register regular vehicles and collect 100" do
        facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
        facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
        camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
        
        facility_1.add_service("Vehicle Registration")
        expect(facility_1.services).to eq(["Vehicle Registration"])
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
        expect(cruz.registration_date).to eq(nil)
        
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(facility_1.collected_fees).to eq(100)
        expect(cruz.registration_date).to eq(Date.today)
      end
      
      it "can register antique vehicles and collect 25" do
        facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
        facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
        camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
        
        facility_1.add_service("Vehicle Registration")
        expect(facility_1.services).to eq(["Vehicle Registration"])
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
        expect(cruz.registration_date).to eq(nil)
        
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(cruz.plate_type).to eq(:regular)
        expect(cruz.registration_date).to eq(Date.today)
        
        facility_1.register_vehicle(camaro)
        expect(facility_1.registered_vehicles).to eq([cruz, camaro])
        expect(camaro.plate_type).to eq(:antique)
        expect(facility_1.collected_fees).to eq(125)
        expect(camaro.registration_date).to eq(Date.today)
      end
      
      it "can register ev vehicles and collect 200" do
        facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
        facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
        camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
        
        facility_1.add_service("Vehicle Registration")
        expect(facility_1.services).to eq(["Vehicle Registration"])
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
        expect(cruz.registration_date).to eq(nil)
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(cruz.plate_type).to eq(:regular)
        expect(cruz.registration_date).to eq(Date.today)
        
        facility_1.register_vehicle(camaro)
        expect(facility_1.registered_vehicles).to eq([cruz, camaro])
        expect(camaro.plate_type).to eq(:antique)
        expect(facility_1.collected_fees).to eq(125)
        expect(camaro.registration_date).to eq(Date.today)
        
        facility_1.register_vehicle(bolt)
        expect(facility_1.registered_vehicles).to eq([cruz, camaro, bolt])
        expect(bolt.plate_type).to eq(:ev)
        expect(facility_1.collected_fees).to eq(325)
        expect(bolt.registration_date).to eq(Date.today)
      end
      
      it "will only register if it has the services to do so" do
        facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
        facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
        cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
        bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
        camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
        
        facility_1.add_service("Vehicle Registration")
        expect(facility_1.services).to eq(["Vehicle Registration"])
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)
        expect(cruz.registration_date).to eq(nil)
        facility_1.register_vehicle(cruz)
        expect(facility_1.registered_vehicles).to eq([cruz])
        expect(cruz.plate_type).to eq(:regular)
        expect(cruz.registration_date).to eq(Date.today)
        
        facility_1.register_vehicle(camaro)
        expect(facility_1.registered_vehicles).to eq([cruz, camaro])
        expect(camaro.plate_type).to eq(:antique)
        expect(facility_1.collected_fees).to eq(125)
        expect(camaro.registration_date).to eq(Date.today)
        
        facility_1.register_vehicle(bolt)
        expect(facility_1.registered_vehicles).to eq([cruz, camaro, bolt])
        expect(bolt.plate_type).to eq(:ev)
        expect(facility_1.collected_fees).to eq(325)
        expect(bolt.registration_date).to eq(Date.today)
        
        expect(facility_2.services).to eq([])
        expect(facility_2.register_vehicle(bolt)).to be nil
        expect(facility_2.registered_vehicles).to eq([])
        expect(facility_2.collected_fees).to eq(0)
      end
    end

    context "registrant" do
      it "exists" do
        registrant_1 = Registrant.new('Bruce', 18, true )
        registrant_2 = Registrant.new('Penny', 16 )
        registrant_3 = Registrant.new('Tucker', 15 )

        expect(registrant_1).to be_an_instance_of(Registrant)
        expect(registrant_2).to be_an_instance_of(Registrant)
        expect(registrant_3).to be_an_instance_of(Registrant)
      end
    end
  end
end
