class Workspace < ApplicationRecord
  extend FriendlyId

  belongs_to :user

  friendly_id :title, use: :slugged

  has_many :posts, dependent: :destroy
  has_many :content_types, dependent: :destroy
  has_many :content_entries
end
