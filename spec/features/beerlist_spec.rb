require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = "Lager"
    @style2 = "Rauchbier"
    @style3 = "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end
  
  it "list is initially sorted by name", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page.all('tr')[1].all('td')[0].text).to eq("Fastenbier")
    expect(page.all('tr')[2].all('td')[0].text).to eq("Lechte Weisse")
    expect(page.all('tr')[3].all('td')[0].text).to eq("Nikolai")
  end
  
  it "order after brewery is clicked", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    
    click_link('brewery')
    
    expect(page.all('tr')[1].all('td')[2].text).to eq("Ayinger")
    expect(page.all('tr')[2].all('td')[2].text).to eq("Koff")
    expect(page.all('tr')[3].all('td')[2].text).to eq("Schlenkerla")
  end
  
  it "order after style is clicked", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    
    click_link('style')
    
    expect(page.all('tr')[1].all('td')[1].text).to eq("Lager")
    expect(page.all('tr')[2].all('td')[1].text).to eq("Rauchbier")
    expect(page.all('tr')[3].all('td')[1].text).to eq("Weizen")
  end
end