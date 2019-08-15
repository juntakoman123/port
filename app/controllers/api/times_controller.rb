require 'base64'
class Api::TimesController < ActionController::API

  def index
    i = 0
    a = []
    b = []
    follows = Follow.where(follower_id: current_user.id)
    follows.each do |f|
      b << Tweet.where(user_id: f.inverse_follower_id) if Tweet.where(user_id: f.inverse_follower_id)
    end
    b << Tweet.where(user_id: current_user.id)
    b.flatten!
    b.sort_by! { |a| a[:id] }
    b.reverse!
    t = b
    while i < t.length
      a[i] = {id: t[i].id, content: t[i].content, user_id: t[i].user_id,created_at: t[i].created_at.strftime("%Y-%m-%d %H:%M"), user_name: t[i].user.name,
      user_image: Base64.encode64(t[i].user.avatar),fav: "far"}
      a[i][:fav] = "fas" if Favorite.find_by(user_id: current_user,tweet_id: a[i][:id])
      favo_num = Favorite.where(tweet_id: a[i][:id]).count
      a[i][:favo_num] = favo_num
      a[i][:belongs] = "own" if a[i][:user_id] == current_user.id
      i = i + 1
    end
    count = Tweet.where(user_id: current_user.id).count
    follow_num = Follow.where(follower_id: current_user.id).count
    follower_num = Follow.where(inverse_follower_id: current_user.id).count
    user = {name: current_user.name, user_image: Base64.encode64(current_user.avatar),tweets_count: count,id: current_user.id,
    follow_num: follow_num,follower_num: follower_num}
    render json: [a,user]
  end
end
