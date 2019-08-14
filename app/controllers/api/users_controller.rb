class Api::UsersController < ActionController::API

  def form_authenticity_token # エラー回避
  end

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    i = 0
    a = []
    u = User.where.not(id: current_user.id).order(created_at: :desc)
    while i < u.length
      a[i] = {id: u[i].id, user_name: u[i].name,user_image_name: u[i].image_name,fd: "no_follow"}
      a[i][:fd] = "followed" if Follow.find_by(follower_id: current_user,inverse_follower_id: a[i][:id])
      tweet_num = Tweet.where(user_id: a[i][:id]).count
      a[i][:tweet_num] = tweet_num
      follow_num = Follow.where(follower_id: a[i][:id]).count
      a[i][:follow_num] = follow_num
      follower_num = Follow.where(inverse_follower_id: a[i][:id]).count
      a[i][:follower_num] = follower_num
      i = i + 1
    end
    render json: a
  end

  def show
    i = 0
    a = []
    u = Tweet.where(user_id: params[:id]).order(created_at: :desc)
    while i < u.length
      a[i] = {id: u[i].id, content: u[i].content, user_id: u[i].user_id,created_at: u[i].created_at.strftime("%Y-%m-%d %H:%M"), user_name: u[i].user.name,
      user_image_name: u[i].user.image_name,fav: "far"}
      a[i][:fav] = "fas" if Favorite.find_by(user_id: current_user,tweet_id: a[i][:id])
      favo_num = Favorite.where(tweet_id: a[i][:id]).count
      a[i][:favo_num] = favo_num
      a[i][:belongs] = "own" if a[i][:user_id] == current_user.id
      i = i + 1
    end

    count = Tweet.where(user_id: params[:id]).count
    follow_num = Follow.where(follower_id: params[:id]).count
    follower_num = Follow.where(inverse_follower_id: params[:id]).count
    @user = User.find_by(id: params[:id])
    user = {name: @user.name, image_name: @user.image_name,tweets_count: count,id: @user.id,
    follow_num: follow_num,follower_num: follower_num,fd: "no_follow"}
    user[:fd] = "followed" if Follow.find_by(follower_id: current_user,inverse_follower_id: user[:id])
    user[:fd] = "own" if @user.id == current_user.id
    render json: [a,user]
  end

  def create
    user = User.new(name: params[:name],password: params[:pass],email: params[:email])
    user.image_name = "default.png"
    if user.save
      login(params[:email], params[:pass] )
      puts logged_in?
      head :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

private
  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
