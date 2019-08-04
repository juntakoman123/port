class Api::TweetsController < ActionController::API

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    tweets = Tweet.select(:content, :user_id, :created_at, :id)
    render json: tweets
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
