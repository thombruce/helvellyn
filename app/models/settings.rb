class Settings < ApplicationRecord
  validates :name, presence: true

  def self.instance(*args)
    first_or_create!(args)
  end
end
