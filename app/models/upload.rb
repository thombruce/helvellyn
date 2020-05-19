class Upload < ApplicationRecord
  belongs_to :workspace

  has_one_attached :file

  validates_presence_of :file
end
