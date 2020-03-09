class Workspace < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :content_types, dependent: :destroy
end
