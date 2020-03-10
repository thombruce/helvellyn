class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :name, use: :scoped, scope: :workspace
end
