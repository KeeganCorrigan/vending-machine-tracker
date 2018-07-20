require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  it "can see a list of snacks in that vending machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create!(title: "snakc", price: 3)
    snack_2 = dons.snacks.create!(title: "snasdij", price: 4)

    visit machine_path(dons)

    expect(page).to have_content(snack_1.title)
    expect(page).to have_content(snack_2.title)
    expect(page).to have_content("Price: $#{snack_1.price}")
    expect(page).to have_content("Price: $#{snack_2.price}")
  end

  it "can see the average price of all snacks in machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create!(title: "snakc", price: 3)
    snack_2 = dons.snacks.create!(title: "snasdij", price: 4)

    visit machine_path(dons)

    expected = 3.5

    expect(page).to have_content("Average price: $#{expected}")
  end
end
