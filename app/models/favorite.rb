class Favorite < ApplicationRecord
  belongs_to :user # userモデルに従属している
  belongs_to :tweet　# tweetモデルに従属している
  
  validates :user_id, uniqueness: { scope: :tweet_id } #　一人のユーザーが同じツイートをおきにいりさせない

end
