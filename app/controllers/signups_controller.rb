class SignupsController < ActionController::API
  def new
    puts logged_in?
    redirect_to root_path if logged_in?
  end
end
