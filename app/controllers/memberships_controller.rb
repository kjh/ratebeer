class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end
  
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end
    
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)

    if @membership.save
      current_user.memberships << @membership
      #redirect_to user_path current_user
      
      redirect_to beer_clubs_path, notice: "#{current_user.username}, welcome to the club!"
    else
      @beer_clubs = BeerClub.all
      render :new
    end
  end  
  
  def destroy
    membership = Membership.find params[:id]
    membership.delete if current_user == membership.user
    redirect_to :back
  end
end
