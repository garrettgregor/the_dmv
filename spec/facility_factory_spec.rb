require "rspec"
require "spec_helper"
require "./lib/facility"
require "./lib/facility_factory"
require "./lib/dmv_data_service"

RSpec.describe FacilityFactory do
  describe "Iteration 3" do
    it "exist" do
      facility_maker = FacilityFactory.new
      
      expect(facility_maker).to be_an_instance_of(FacilityFactory)
    end
    
    context "different factories" do
      it "can make a facility out of NY facilities" do
        facility_maker = FacilityFactory.new
        new_york_facilities_raw_data = DmvDataService.new.ny_dmv_office_locations
        ny_facilities = facility_maker.create_facilities(new_york_facilities_raw_data)
        
        expect(ny_facilities).to be_an(Array)
        expect(ny_facilities[0].name).to eq("SELDEN")
        expect(ny_facilities[0].phone).to be nil
        expect(ny_facilities[0].address).to eq("407 SELDEN RD, SELDEN, NY 11784")
        expect(ny_facilities[0].registered_vehicles).to eq([])
        expect(ny_facilities[0].services).to eq([])
        expect(ny_facilities[0].collected_fees).to eq(0)
        
        expect(ny_facilities[2].name).to eq("SARANAC LAKE")
        expect(ny_facilities[2].phone).to eq("5188911748")
        expect(ny_facilities[2].address).to eq("39 MAIN STREET, SARANAC LAKE, NY 12983")
        expect(ny_facilities[2].registered_vehicles).to eq([])
        expect(ny_facilities[2].services).to eq([])
        expect(ny_facilities[2].collected_fees).to eq(0)
      end

      it "can make a facility out of MO facilities" do
        facility_maker = FacilityFactory.new
        missouri_facilities_raw_data = DmvDataService.new.mo_dmv_office_locations
        mo_facilities = facility_maker.create_facilities(missouri_facilities_raw_data)
        
        expect(mo_facilities).to be_an(Array)
        expect(mo_facilities[0].name).to eq("OAKVILLE")
        expect(mo_facilities[0].phone).to eq("(314) 887-1050")
        expect(mo_facilities[0].address).to eq("3164 TELEGRAPH ROAD, ST LOUIS, MO 63125")
        expect(mo_facilities[0].registered_vehicles).to eq([])
        expect(mo_facilities[0].services).to eq([])
        expect(mo_facilities[0].collected_fees).to eq(0)
        
        expect(mo_facilities[2].name).to eq("LICKING (closed)")
        expect(mo_facilities[2].phone).to be nil
        expect(mo_facilities[2].address).to eq("117A NORTH MAIN, LICKING, MO 65542")
        expect(mo_facilities[2].registered_vehicles).to eq([])
        expect(mo_facilities[2].services).to eq([])
        expect(mo_facilities[2].collected_fees).to eq(0)
      end
      
      it "can make a facility out of OR facilities" do
        facility_maker = FacilityFactory.new
        oregon_facilities_raw_data = DmvDataService.new.or_dmv_office_locations
        or_facilities = facility_maker.create_facilities(oregon_facilities_raw_data)
        
        expect(or_facilities).to be_an(Array)
        expect(or_facilities[0].name).to eq("Albany DMV Office")
        expect(or_facilities[0].phone).to eq("541-967-2014")
        expect(or_facilities[0].address).to eq("2242 Santiam Hwy SE, Albany, OR 97321")
        expect(or_facilities[0].registered_vehicles).to eq([])
        expect(or_facilities[0].services).to eq([])
        expect(or_facilities[0].collected_fees).to eq(0)
        
        expect(or_facilities[2].name).to eq("Astoria DMV Office")
        expect(or_facilities[2].phone).to eq("503-325-3951")
        expect(or_facilities[2].address).to eq("705 W Marine Dr, Astoria, OR 97103")
        expect(or_facilities[2].registered_vehicles).to eq([])
        expect(or_facilities[2].services).to eq([])
        expect(or_facilities[2].collected_fees).to eq(0)
      end

      context "helper methods" do
        it "formats names" do
          facility_maker = FacilityFactory.new
          ny_name_data = {
            :office_name=>"SELDEN",
            :office_type=>"MOBILE OFFICE",
            :street_address_line_1=>"407 SELDEN RD",
            :city=>"SELDEN",
            :state=>"NY",
            :zip_code=>"11784",
            :monday_beginning_hours=>"8:00 AM",
            :monday_ending_hours=>"6:00 PM",
            :tuesday_beginning_hours=>"8:00 AM",
            :tuesday_ending_hours=>"6:00 PM",
            :wednesday_beginning_hours=>"8:00 AM",
            :wednesday_ending_hours=>"6:00 PM",
            :thursday_beginning_hours=>"8:00 AM",
            :thursday_ending_hours=>"6:00 PM",
            :friday_beginning_hours=>"8:00 AM",
            :friday_ending_hours=>"6:00 PM"
          }
          expect(facility_maker.format_name(ny_name_data)).to eq("SELDEN")
          
          or_name_data = {
            :title=>"Albany DMV Office",
            :zip_code=>"97321",
            :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx",
            :type=>"DMV Location",
            :phone_number=>"541-967-2014",
            :agency=>"Transportation, Department of ",
            :location_1=>{:latitude=>"44.632897", :longitude=>"-123.077928", :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}
          }
          expect(facility_maker.format_name(or_name_data)).to eq("Albany DMV Office")
          
          mo_name_data = {
            :number=>"166",
            :dorregionnumber=>"8",
            :type=>"1MV",
            :name=>"OAKVILLE",
            :address1=>"3164 TELEGRAPH ROAD",
            :city=>"ST LOUIS",
            :state=>"MO",
            :zipcode=>"63125",
            :county=>"St. Louis County",
            :phone=>"(314) 887-1050",
            :fax=>"(314) 887-1051",
            :size=>"3",
            :email=>"OAKVILLEAGENTOFFICE@DOR.MO.GOV",
            :agent=>"York Management Group, LLC.",
            :officemanager=>"Rita Lahr",
            :daysopen=>"Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00",
            :holidaysclosed=>
              "Thanksgiving (11/24/22), Christmas Day Observed (12/26/22), New Year's Day Observed (01/02/23), Martin Luther King Day (01/16/23), President’s Day (02/20/23), Memorial Day (05/29/23), Juneteenth (06/19/2023), Independence Day (07/04/23), Labor Day (09/04/23), Veterans Day (11/10/23), Thanksgiving (11/23/23), Christmas Day Observed (12/25/23)",
            :additionaldaysclosed=>
              "7/2/22,     9/3/22,     11/25/22,     11/26/22,     11/28/2022 (at 11:45 AM),     12/22/2022 (at 1:30 PM ),     12/31/22,    1/25/2023 (at 9:00 AM until 11:00 AM ),    1/25/2023 (open at 11:00 AM ),   1/30/2023 (at 9:00 AM until 10:00 AM ),   1/30/2023 (open at 10:00 AM ),  2/22/2023 (at 3:00 PM ),     5/27/23,     9/2/23,     11/24/23,     11/25/23,     12/30/23",
            :latlng=>{:latitude=>"38.4981572", :longitude=>"-90.3001675"},
            :facebook_url=>"https://m.facebook.com/people/Oakville-License-Office/100069096876261/",
            :textingphonenumber=>"(314) 730-0606",
            :othercontactinfo=>"Public Email: oakville@yorkmanagementgroup.com",
            :":@computed_region_ny2h_ckbz"=>"248",
            :":@computed_region_c8ar_jsdj"=>"51",
            :":@computed_region_ikxf_gfzr"=>"2210"
          }
          expect(facility_maker.format_name(mo_name_data)).to eq("OAKVILLE")
        end
        
        it "formats number" do
          facility_maker = FacilityFactory.new
          ny_data = {
            :office_name=>"SELDEN",
            :office_type=>"MOBILE OFFICE",
            :street_address_line_1=>"407 SELDEN RD",
            :city=>"SELDEN",
            :state=>"NY",
            :zip_code=>"11784",
            :monday_beginning_hours=>"8:00 AM",
            :monday_ending_hours=>"6:00 PM",
            :tuesday_beginning_hours=>"8:00 AM",
            :tuesday_ending_hours=>"6:00 PM",
            :wednesday_beginning_hours=>"8:00 AM",
            :wednesday_ending_hours=>"6:00 PM",
            :thursday_beginning_hours=>"8:00 AM",
            :thursday_ending_hours=>"6:00 PM",
            :friday_beginning_hours=>"8:00 AM",
            :friday_ending_hours=>"6:00 PM"
          }
          expect(facility_maker.format_phone(ny_data)).to be nil
          
          or_data = {
            :title=>"Albany DMV Office",
            :zip_code=>"97321",
            :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx",
            :type=>"DMV Location",
            :phone_number=>"541-967-2014",
            :agency=>"Transportation, Department of ",
            :location_1=>{:latitude=>"44.632897", :longitude=>"-123.077928", :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}
          }
          expect(facility_maker.format_phone(or_data)).to eq("541-967-2014")
          
          mo_data = {
            :number=>"166",
            :dorregionnumber=>"8",
            :type=>"1MV",
            :name=>"OAKVILLE",
            :address1=>"3164 TELEGRAPH ROAD",
            :city=>"ST LOUIS",
            :state=>"MO",
            :zipcode=>"63125",
            :county=>"St. Louis County",
            :phone=>"(314) 887-1050",
            :fax=>"(314) 887-1051",
            :size=>"3",
            :email=>"OAKVILLEAGENTOFFICE@DOR.MO.GOV",
            :agent=>"York Management Group, LLC.",
            :officemanager=>"Rita Lahr",
            :daysopen=>"Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00",
            :holidaysclosed=>
              "Thanksgiving (11/24/22), Christmas Day Observed (12/26/22), New Year's Day Observed (01/02/23), Martin Luther King Day (01/16/23), President’s Day (02/20/23), Memorial Day (05/29/23), Juneteenth (06/19/2023), Independence Day (07/04/23), Labor Day (09/04/23), Veterans Day (11/10/23), Thanksgiving (11/23/23), Christmas Day Observed (12/25/23)",
            :additionaldaysclosed=>
              "7/2/22,     9/3/22,     11/25/22,     11/26/22,     11/28/2022 (at 11:45 AM),     12/22/2022 (at 1:30 PM ),     12/31/22,    1/25/2023 (at 9:00 AM until 11:00 AM ),    1/25/2023 (open at 11:00 AM ),   1/30/2023 (at 9:00 AM until 10:00 AM ),   1/30/2023 (open at 10:00 AM ),  2/22/2023 (at 3:00 PM ),     5/27/23,     9/2/23,     11/24/23,     11/25/23,     12/30/23",
            :latlng=>{:latitude=>"38.4981572", :longitude=>"-90.3001675"},
            :facebook_url=>"https://m.facebook.com/people/Oakville-License-Office/100069096876261/",
            :textingphonenumber=>"(314) 730-0606",
            :othercontactinfo=>"Public Email: oakville@yorkmanagementgroup.com",
            :":@computed_region_ny2h_ckbz"=>"248",
            :":@computed_region_c8ar_jsdj"=>"51",
            :":@computed_region_ikxf_gfzr"=>"2210"
          }
          expect(facility_maker.format_phone(mo_data)).to eq("(314) 887-1050")
        end
        
        it "formats address" do
          facility_maker = FacilityFactory.new
          ny_data = {
            :office_name=>"SELDEN",
            :office_type=>"MOBILE OFFICE",
            :street_address_line_1=>"407 SELDEN RD",
            :city=>"SELDEN",
            :state=>"NY",
            :zip_code=>"11784",
            :monday_beginning_hours=>"8:00 AM",
            :monday_ending_hours=>"6:00 PM",
            :tuesday_beginning_hours=>"8:00 AM",
            :tuesday_ending_hours=>"6:00 PM",
            :wednesday_beginning_hours=>"8:00 AM",
            :wednesday_ending_hours=>"6:00 PM",
            :thursday_beginning_hours=>"8:00 AM",
            :thursday_ending_hours=>"6:00 PM",
            :friday_beginning_hours=>"8:00 AM",
            :friday_ending_hours=>"6:00 PM"
          }
          expect(facility_maker.format_address(ny_data)).to eq("407 SELDEN RD, SELDEN, NY 11784")
          
          or_data = {
            :title=>"Albany DMV Office",
            :zip_code=>"97321",
            :website=>"http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx",
            :type=>"DMV Location",
            :phone_number=>"541-967-2014",
            :agency=>"Transportation, Department of ",
            :location_1=>{:latitude=>"44.632897", :longitude=>"-123.077928", :human_address=>"{\"address\": \"2242 Santiam Hwy SE\", \"city\": \"Albany\", \"state\": \"OR\", \"zip\": \"97321\"}"}
          }
          expect(facility_maker.format_address(or_data)).to eq("2242 Santiam Hwy SE, Albany, OR 97321")
          
          mo_data = {
            :number=>"166",
            :dorregionnumber=>"8",
            :type=>"1MV",
            :name=>"OAKVILLE",
            :address1=>"3164 TELEGRAPH ROAD",
            :city=>"ST LOUIS",
            :state=>"MO",
            :zipcode=>"63125",
            :county=>"St. Louis County",
            :phone=>"(314) 887-1050",
            :fax=>"(314) 887-1051",
            :size=>"3",
            :email=>"OAKVILLEAGENTOFFICE@DOR.MO.GOV",
            :agent=>"York Management Group, LLC.",
            :officemanager=>"Rita Lahr",
            :daysopen=>"Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00",
            :holidaysclosed=>
              "Thanksgiving (11/24/22), Christmas Day Observed (12/26/22), New Year's Day Observed (01/02/23), Martin Luther King Day (01/16/23), President’s Day (02/20/23), Memorial Day (05/29/23), Juneteenth (06/19/2023), Independence Day (07/04/23), Labor Day (09/04/23), Veterans Day (11/10/23), Thanksgiving (11/23/23), Christmas Day Observed (12/25/23)",
            :additionaldaysclosed=>
              "7/2/22,     9/3/22,     11/25/22,     11/26/22,     11/28/2022 (at 11:45 AM),     12/22/2022 (at 1:30 PM ),     12/31/22,    1/25/2023 (at 9:00 AM until 11:00 AM ),    1/25/2023 (open at 11:00 AM ),   1/30/2023 (at 9:00 AM until 10:00 AM ),   1/30/2023 (open at 10:00 AM ),  2/22/2023 (at 3:00 PM ),     5/27/23,     9/2/23,     11/24/23,     11/25/23,     12/30/23",
            :latlng=>{:latitude=>"38.4981572", :longitude=>"-90.3001675"},
            :facebook_url=>"https://m.facebook.com/people/Oakville-License-Office/100069096876261/",
            :textingphonenumber=>"(314) 730-0606",
            :othercontactinfo=>"Public Email: oakville@yorkmanagementgroup.com",
            :":@computed_region_ny2h_ckbz"=>"248",
            :":@computed_region_c8ar_jsdj"=>"51",
            :":@computed_region_ikxf_gfzr"=>"2210"
          }
          expect(facility_maker.format_address(mo_data)).to eq("3164 TELEGRAPH ROAD, ST LOUIS, MO 63125")
        end
      end
    end
  end
end
