require 'base64'
class Api::FavoritesController < ActionController::API
  def create
      favorite = Favorite.new(user_id: current_user.id, tweet_id: params[:id])
      if favorite.save
        head :created
      else
        render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
  end

  def destroy
      favorite = Favorite.find_by(user_id: current_user.id, tweet_id: params[:id])
      favorite.destroy
      head :no_content
  end

  def show
    i = 0
    a = []
    b = []
    favs = Favorite.where(user_id: params[:id]).order(created_at: :desc)
    favs.each do |f|
      b << Tweet.find_by(id: f.tweet_id)
    end

    while i < b.length
      a[i] = {id: b[i].id, content: b[i].content, user_id: b[i].user_id,created_at: b[i].created_at.strftime("%Y-%m-%d %H:%M"), user_name: b[i].user.name,
      user_image: Base64.encode64(b[i].user.avatar),fav: "far"}
      a[i][:fav] = "fas" if Favorite.find_by(user_id: current_user,tweet_id: a[i][:id])
      favo_num = Favorite.where(tweet_id: a[i][:id]).count
      a[i][:favo_num] = favo_num
      i = i + 1
    end

    count = Tweet.where(user_id: params[:id]).count
    follow_num = Follow.where(follower_id: params[:id]).count
    follower_num = Follow.where(inverse_follower_id: params[:id]).count
    @user = User.find_by(id: params[:id])
    user = {name: @user.name, user_image: Base64.encode64(@user.avatar),tweets_count: count,id: @user.id,
    follow_num: follow_num,follower_num: follower_num,fd: "no_follow"}
    user[:fd] = "followed" if Follow.find_by(follower_id: current_user,inverse_follower_id: user[:id])
    user[:fd] = "own" if @user.id == current_user.id
    render json: [a,user]
  end

end
