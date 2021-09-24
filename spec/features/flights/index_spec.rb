require 'rails_helper'

describe 'Flights Index Page' do
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

  it 'lists all flight numbers' do
    visit('/flights')

    Flight.all.each do |flight|
      expect(page).to have_content(flight.number)
      expect(page).to have_content(flight.airline.name)

      flight.flight_passengers.each do |passenger|
        expect(page).to have_content(passenger.passenger.name)
      end
    end
  end

  describe 'Remove Passenger' do
    it 'button by all names' do
      visit('/flights')

      click_on("Remove #{@john.name}")

      # save_and_open_page
      expect(current_path).to eq('/flights')
      expect(page).not_to have_content(@john.name)
    end
  end
end
