class Settings < ApplicationRecord
  validates :name, presence: true

  def self.instance
    first_or_create!
  end
end
