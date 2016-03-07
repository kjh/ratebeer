class BreweriesController < ApplicationController
  before_action :set_order_and_reverse, only: [:index]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:destroy]
  
  # GET /ngbrewerieslist
  def nglist
  end

  # GET /breweries
  # GET /breweries.json
  def index
    unless fragment_exist?( 'brewerylist-#{@order}-#{@reverse}' )
      # json
      @breweries = Brewery.all
      
      #(byebug)
      
      @active_breweries = case @order
        when 'name' then Brewery.active.sort_by &:name
        when 'year' then Brewery.active.sort_by &:year  
      end
      @retired_breweries = case @order
        when 'name' then Brewery.retired.sort_by &:name
        when 'year' then Brewery.retired.sort_by &:year  
      end
      
      if @reverse
        @active_breweries.reverse!
        @retired_breweries.reverse!
      end
      
      #@active_breweries = Brewery.active #where(active:true)
      #@retired_breweries = Brewery.retired #where(active:[nil, false])
    end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    ["brewerylist-name-false", "brewerylist-name-true", "brewerylist-year-false", "brewerylist-year-true"].each{ |f| expire_fragment(f) }
    
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    ["brewerylist-name-false", "brewerylist-name-true", "brewerylist-year-false", "brewerylist-year-true"].each{ |f| expire_fragment(f) }
    
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    ["brewerylist-name-false", "brewerylist-name-true", "brewerylist-year-false", "brewerylist-year-true"].each{ |f| expire_fragment(f) }
    
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_order_and_reverse
      @order = params[:order] || 'name'
      if session[:order_reverse].nil?
        @reverse = session[:order_reverse] = false
      else
        @reverse = session[:order_reverse] = !session[:order_reverse]
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
    
    def authenticate
      admin_accounts = { "admin" => "secret", "pekka" => "beer" }
      
      authenticate_or_request_with_http_basic do |username, password|
        admin_accounts.each do |k, v| 
          if username == k and password == v 
            true 
          end
        end
      end
    end
end
