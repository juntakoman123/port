class Tweet < ApplicationRecord


  belongs_to :user #userモデルに所属する
  has_many :favorites　#　複数のおきにいりをもっている

  validates :user_id, presence: true # user_idは必須
  validates :content, presence: true, length: { in: 1..140}# コンテンツの条件を指定
end
