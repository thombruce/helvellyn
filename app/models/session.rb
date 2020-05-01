class Session < ApplicationRecord
  include Credible::Session

  belongs_to :workspace, optional: true

  attr_accessor :current_workspace

  private	

  def access_token_data	
    {	
      session_id: id,	
      user_id: user.id,	
      user: {	
        id: user.id,	
        name: user.name,	
        email: user.email,	
        admin: user.admin	
      }	
    }	
  end
end
