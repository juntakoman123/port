
 # 60.times do |n|
 #  User.create(name: "#{n + 1}test",email: "test#{n + 1}.gmail.com",password: "111111",image_name: "default.png")
 # end

# 80.times do |n|
#   Tweet.create(user_id: 73,content: "user_idが1の#{n}回目のテスト投稿")
# end

30.times do |n|
  Favorite.create(user_id: 74,tweet_id: n + 83)
end
