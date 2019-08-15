require 'base64'
class Api::FollowingsController < ActionController::API

  def show
    i = 0
    a = []
    b = []
    follows = Follow.where(follower_id: params[:id])
    follows.each do |f|
      b << User.find_by(id: f.inverse_follower_id)
    end

    while i < b.length
      a[i] = {id: b[i].id, user_name: b[i].name,user_image: Base64.encode64(b[i].avatar),fd: "no_follow"}
      a[i][:fd] = "followed" if Follow.find_by(follower_id: current_user,inverse_follower_id: a[i][:id])
      a[i][:fd] = "own" if a[i][:id] == current_user.id
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
end
