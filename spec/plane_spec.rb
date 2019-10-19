require 'plane.rb'
require 'airport.rb'

describe Plane do
  let(:plane) {Plane.new}
  let(:airport) {Airport.new}

  context "airport capacity" do

    it "a new airport is created with a default capacity of 20" do
      expect(airport.capacity).to eq(20)
    end

    it "a new airport can be created with a custom capacity" do
      sml_airport = Airport.new(5)
      expect(sml_airport.capacity).to eq(5)
    end
  end

  context "landing a plane" do

    it "lands a plane in an airport" do
      expect(airport.land(plane)).to eq("The plane has safely landed")
    end

    it "when a plane lands the airport stores the plane" do
      airport.land(plane)
      expect(airport.grounded_planes).to include(plane)
    end

    it "a plane that is already landed cannot land again" do
      plane.landed
      expect{airport.land(plane)}.to raise_error("That plane has already landed")
    end

    it "a plane cannot land if the airport is full" do
      airport.capacity.times { airport.land(Plane.new) }
      expect{airport.land(plane)}.to raise_error("There are too many planes in the airport")
    end

  end

  context "plane taking off" do

    it "plane takes off from an airport" do
      airport.land(plane)
      expect(airport.takeoff(plane)).to eq("The plane is in the air")
    end

    it "confirms when a plane takes off it is no longer in the airport" do
      airport.land(plane)
      airport.takeoff(plane)
      expect(airport.grounded_planes).not_to include(plane)
    end

    it "throws an error if a plane that is not in the airport tries to take off" do
      expect{airport.takeoff(plane)}.to raise_error("That plane is not in this airport")
    end

  end

end
