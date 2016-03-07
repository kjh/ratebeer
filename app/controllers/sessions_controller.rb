class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end
  
  def create
    #Operaation suorittamista varten tietokanta joutuu käymään läpi koko users-taulun. 
    #Haut olion id:n suhteen ovat nopeampia, sillä jokainen taulu on indeksöity id:iden suhteen. 
    #Indeksi toimii hajautustaulun tavoin, eli tarjoaa "O(1)"-ajassa toimivan pääsyn haettuun tietokannan riviin.
        user = User.find_by username: params[:username]
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to user_path(user), notice: "Welcome back!"
        else
          redirect_to :back, notice: "Username and/or password mismatch"
        end
      end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end