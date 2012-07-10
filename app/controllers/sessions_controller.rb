class SessionsController < ApplicationController
  def create
    user = User.from_omniauth('omniauth.auth')
    session[:user_id] = user.id
    redirect_to '/game#index'
  end
end

