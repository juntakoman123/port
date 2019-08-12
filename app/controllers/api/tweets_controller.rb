class Api::TweetsController < ActionController::API

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    i = 0
    a = []
    t = Tweet.order(created_at: :desc)
    while i < Tweet.all.length
      a[i] = {id: t[i].id, content: t[i].content, user_id: t[i].user_id,created_at: t[i].created_at.strftime("%Y-%m-%d %H:%M"), user_name: t[i].user.name,
      user_image_name: t[i].user.image_name,fav: "far"}
      a[i][:fav] = "fas" if Favorite.find_by(user_id: current_user,tweet_id: a[i][:id])
      favo_num = Favorite.where(tweet_id: a[i][:id]).count
      a[i][:favo_num] = favo_num
      i = i + 1
    end
    count = Tweet.all.where(user_id: current_user.id).count
    follow_num = Follow.where(follower_id: current_user.id).count
    follower_num = Follow.where(inverse_follower_id: current_user.id).count
    user = {name: current_user.name, image_name: current_user.image_name,tweets_count: count,id: current_user.id,
    follow_num: follow_num,follower_num: follower_num}
    render json: [a,user]
  end

  def create
    tweet = Tweet.new(content: params[:text],user_id: current_user.id)
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

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
