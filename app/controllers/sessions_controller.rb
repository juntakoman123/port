class SessionsController < ActionController::API
  def login
  end

  def create
     email = params_user[:email]
     password = params_user[:pass]
     if login(email, password)#sorceryによるもの
       head :created
     else
      render json: { errors: "Ｅメールもしくはパスワードが間違っています" }, status: :unprocessable_entity
     end
  end

  def destroy
    logout
  end


end
