class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :tweets　# 複数のユーザーを持ってる
  has_many :favorites　#　複数のお気に入りを持っている
  validates :name, presence: true # 空白を防ぐ
  validates :email, presence: true, uniqueness: { case_sensitive: false } #emailの一意性を作る
  validates :password, length: { in: 6..24 }


end
