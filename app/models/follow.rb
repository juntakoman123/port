class Follow < ApplicationRecord
  belongs_to :follower, class_name: User #関連するモデル名を指定して分別させる
  belongs_to :inverse_follower, class_name: User
end
