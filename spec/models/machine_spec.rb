require "rails_helper"

describe Machine, type: :model do
  describe "instance methods" do
    describe ".average_snack_price" do
      it "returns average price of all snacks" do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = dons.snacks.create!(title: "snakc", price: 3)
        snack_2 = dons.snacks.create!(title: "snasdij", price: 4)

        expected = 3.5

        expect(dons.average_snack_price).to eq(expected)
      end
    end

    describe ".snack_count" do
      it "returns number of snacks in machine" do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = dons.snacks.create!(title: "snakc", price: 3)
        snack_2 = dons.snacks.create!(title: "snasdij", price: 4)

        expected = 2

        expect(dons.snack_count).to eq(expected)
      end
    end
  end
end
