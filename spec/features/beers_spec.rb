require 'rails_helper'

describe "Beers" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  it "with name is saved" do
    visit new_beer_path
    fill_in('beer[name]', with:'Test Beer')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end
  
  it "with missing name is not saved" do
    visit new_beer_path

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    
    expect(page).to have_content "Name can't be blank"
  end
end