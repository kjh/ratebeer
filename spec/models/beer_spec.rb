require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved when name and style is set correcty" do
      beer = Beer.create name:"testi", style:"testi"
      
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
  end
  
  it "it is not saved when name is not set" do
      beer = Beer.create 
      
      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
  end
  
  it "it is not saved when style is not set" do
      beer = Beer.create name:"testi"
      
      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
  end

end
