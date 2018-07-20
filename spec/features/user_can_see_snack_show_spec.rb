require "rails_helper"

describe "a user visits snack show" do
  it "sees name and price of snack" do
    snack_1 = Snack.create!(title: "snakc", price: 3)

    visit snack_path(snack_1)

    expect(page).to have_content(snack_1.title)
    expect(page).to have_content("Price: #{snack_1.price}")
  end

  it "sees locations with vending machines that carry that snack" do
    owner = Owner.create!(name: "Sam's Snacks")
    owner_1 = Owner.create!(name: "other snacks")
    machine_1 = owner_1.machines.create!(location: "Other snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create!(title: "snakc", price: 3)

    MachineSnack.create(machine: machine_1, snack: snack_1)

    visit snack_path(snack_1)

    expect(page).to have_content(dons.location)
    expect(page).to have_content(machine_1.location)
  end

  it "sees count of different kinds of items in those vending machines" do
    owner = Owner.create!(name: "Sam's Snacks")
    owner_1 = Owner.create!(name: "other snacks")
    machine_1 = owner_1.machines.create!(location: "Other snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create!(title: "snakc", price: 3)
    snack_2 = machine_1.snacks.create!(title: "oiasdo", price: 5)

    MachineSnack.create(machine: machine_1, snack: snack_1)

    visit snack_path(snack_1)

    expected_2 = 2

    expected_1 = 1

    expect(page).to have_content("Snacks: #{expected_2}")
    expect(page).to have_content("Snacks: #{expected_1}")

  end
  it "sees average price of items in those vending machines" do
    owner = Owner.create!(name: "Sam's Snacks")
    owner_1 = Owner.create!(name: "other snacks")
    machine_1 = owner_1.machines.create!(location: "Other snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create!(title: "snakc", price: 3)
    snack_2 = machine_1.snacks.create!(title: "oiasdo", price: 5)

    MachineSnack.create(machine: machine_1, snack: snack_1)

    visit snack_path(snack_1)

    save_and_open_page

    expected_1 = machine_1.average_snack_price

    expected_2 = dons.average_snack_price


    expect(page).to have_content("Average price: $#{expected_1}")
    expect(page).to have_content("Average price: $#{expected_2}")
  end
end
