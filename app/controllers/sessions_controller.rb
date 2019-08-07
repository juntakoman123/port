class SessionsController < ActionController::API
  def form_authenticity_token # エラー回避
  end

  def new
    puts logged_in?
    redirect_to root_path if logged_in?
  end

  def create
     email = params[:email]
     password = params[:pass]
     puts email
     puts password
     if login(email, password)#sorceryによるもの
       head :created
       puts "ログイン成功"
       puts logged_in?
       puts current_user.name
     else
      render json: { errors: "Ｅメールもしくはパスワードが間違っています" }, status: :unprocessable_entity
       puts "ログイン失敗"
     end
  end

  def destroy
    logout
    puts "ログアウト"
    puts logged_in?
  end


end
