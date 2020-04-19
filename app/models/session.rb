class Session < ApplicationRecord
  include Credible::Session

  belongs_to :workspace, optional: true

  attr_accessor :current_workspace
end
