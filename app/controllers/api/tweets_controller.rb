class Api::TweetsController < ActionController::API

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    i = 0
    a = []
    t = Tweet.all
    while i < Tweet.all.length
      a[i] = {id: t[i].id, content: t[i].content, user_id: t[i].user_id,created_at: t[i].created_at, user_name: t[i].user.name,
      user_image_name: t[i].user.image_name}
      i = i + 1 # iの更新
    end
    
    count = Tweet.all.where(user_id: current_user.id).count
    user = {name: current_user.name, image_name: current_user.image_name,tweets_count: count,id: current_user.id}
    render json: [a,user]
  end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save
      render json: tweet, status: :created
    else
      render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    Tweet.find(params[:id]).destroy!
    head :no_content
  end


private


  def tweet_params
    params.fetch(:tweet, {}).permit(:content, :user_id) # {}はデフォルト
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end


end
