module EntitiesSorter
  extend ActiveSupport::Concern

  included do
  end

  # The default values are 'created_at' and true for descending, resulting in most recently created first.
  # This is overridden either by setting :sort and :desc on the Template instance or by providing
  # sort= and desc= query parameters. These query parameters take precedence.
  def entities_order
    if params[:sort]
      # If params[:desc] is 'true', nil or anything other than 'false', returns :desc by default
      {params[:sort] => (params[:desc] == 'false' ? :asc : :desc)}
    else
      @template.default_order
    end
  end
end