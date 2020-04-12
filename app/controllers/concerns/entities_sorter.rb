module EntitiesSorter
  extend ActiveSupport::Concern

  included do
  end

  def entities_order
    # NOTE: Good enough at present, but for many cases we would prefer that desc be treated as the default.
    #       That is a consideration for part two of this job: allowing the setting of a default sort order.
    {(params[:sort] || 'created_at') => (params[:desc] == 'true' ? :desc : :asc)}
  end
end