class PlacesController < ApplicationController
  def index
    #rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    #tallentetaan tehdyn reittauksen sessioon
    #session[:last_search] = "#{rating.beer.name} #{rating.score} points"
  end
  
  def show
    # find by city and id ?
    @place = Place.new 
    @place.id = params[:id]
    
    @places = BeermappingApi.places_in("#{session[:last_search]}")
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{session[:last_search]}"
    else
      @places.each do |p|
        if p.id ==  @place.id
          @place.name = p.name
          @place.street = p.street
          @place.city = p.city
          @place.zip = p.zip
          break
        end
      end
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_search] = "#{params[:city]}"
    (byebug)
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end