class Upload < ApplicationRecord
  belongs_to :workspace

  has_one_attached :file
end
