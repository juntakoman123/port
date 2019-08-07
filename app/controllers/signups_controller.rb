class SignupsController < ActionController::API
  def new
    puts logged_in?
    redirect_to "/" if logged_in?
  end
end
