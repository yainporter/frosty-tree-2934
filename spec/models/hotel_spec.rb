require "rails_helper"

RSpec.describe Hotel, type: :model do
  describe "relationships" do
    it { should have_many :rooms }
    it { should have_many :reservations }
  end

  before(:each) do
    @turing = Hotel.create!(name: "Turing", location: "Colorado")
    @fsa = Hotel.create!(name: "Fullstack Academy", location: "New York")
    @hack_reactor = Hotel.create!(name: "Hack Reactor", location: "Phoenix")

    @turing_single_suite = Room.create!(rate: 130, suite: "Single", hotel_id: @turing.id)
    @fsa_single_suite = Room.create!(rate: 150, suite: "Single", hotel_id: @fsa.id)
    @hack_reactor_king_suite = Room.create!(rate: 300, suite: "King", hotel_id: @hack_reactor.id)

    @rob = Guest.create!(name: "Rob", nights: 4)

    @reservation_fsa = Reservation.create!(room_id: @fsa_single_suite.id, guest_id: @rob.id)
    @reservation_turing = Reservation.create!(room_id: @turing_single_suite.id, guest_id: @rob.id)
  end

  describe "#find_all_uniq_guests" do
    it "returns a unique list of all guests from the hotel" do
      expect(@hack_reactor.find_all_uniq_guests).to eq([@rob])
    end

  end
end
