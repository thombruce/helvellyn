class ContentEntry < ApplicationRecord
  belongs_to :workspace
  belongs_to :content_type
end
