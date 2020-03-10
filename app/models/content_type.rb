class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :name, use: :scoped, scope: :workspace

  has_many :content_entries, dependent: :destroy

  def sanitized_fields # TODO: good case for a decorator if you don't fix by fixing below.
    fields&.map { |field| field.merge({slug: field["name"].parameterize}) } # TODO: We need to also ensure uniqueness of these slugs somehow... and maybe allow user to set.
  end
end
