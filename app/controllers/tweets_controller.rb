class TweetsController < ApplicationController
  def index
    redirect_to "/registrations/new" unless logged_in?
  end
end
