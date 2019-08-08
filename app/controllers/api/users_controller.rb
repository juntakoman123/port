class Api::UsersController < ActionController::API

  def form_authenticity_token # エラー回避
  end

  before_action :set_user, only: [:show,:update]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    users = User.select(:id, :name, :image_name)
    render json: users
  end

  def index
    i = 0
    a = []
    u = User.where.not(id: current_user.id)
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
    render json: @user
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

  def update
    if params[:image]
      @user.image_name = "#{@user.id}.png"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end

    @user.name = params[:name]

    if @user.save
      head :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :pass, :email) # {}はデフォルト
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end


end
