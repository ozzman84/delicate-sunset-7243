require 'rails_helper'

describe 'Airline Show Page' do
  describe 'as a visitor' do
    before :each do
      @freefall = Airline.create!(name: 'Free Fall')
      @bermudatriangle = Airline.create!(name: 'Bermuda Triangle')
      @flytoolow = @freefall.flights.create!(number: 739, date: 'Jan 21, 2020', departure_city: 'Denver', arrival_city: 'Phoenix')
      @lookmanohands = @freefall.flights.create!(number: 303, date: 'Feb 21, 2020', departure_city: 'Denver', arrival_city: 'Metroplis')
      @takethewheel = @freefall.flights.create!(number: 111, date: 'March 21, 2020', departure_city: 'Denver', arrival_city: 'Star City')
      @waterlanding = @bermudatriangle.flights.create!(number: 3, date: 'April 21, 2020', departure_city: 'Phoenix', arrival_city: 'Gatham')
      @john = Passenger.create!(name: 'John', age: 18)
      @steve = Passenger.create!(name: 'Steve', age: 17)
      @eddie = Passenger.create!(name: 'Eddie', age: 27)
      @ron = Passenger.create!(name: 'Ron', age: 27)
      @jen = Passenger.create!(name: 'Jen', age: 27)
      @john_flytoolow = FlightPassenger.create!(flight_id: @flytoolow.id, passenger_id: @john.id)
      @steve_flytoolow = FlightPassenger.create!(flight_id: @flytoolow.id, passenger_id: @steve.id)
      @eddie_lookmanohands = FlightPassenger.create!(flight_id: @lookmanohands.id, passenger_id: @eddie.id)
      @ron_takethewheel = FlightPassenger.create!(flight_id: @takethewheel.id, passenger_id: @ron.id)
      @jen_waterlanding = FlightPassenger.create!(flight_id: @waterlanding.id, passenger_id: @jen.id)
    end

    describe 'lists that Airlines Passengers' do
      it 'only shows uniq passengers under age 18' do
        visit "/airlines/#{@freefall.id}"

        @freefall.adult_passengers.each do |passenger|
          expect(page).to have_content(passenger.name)
        end

        expect(page).not_to have_content(@jen.name)
        expect(page).not_to have_content(@steve.name)
      end
    end
  end
end
