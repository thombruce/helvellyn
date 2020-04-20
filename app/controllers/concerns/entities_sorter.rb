module EntitiesSorter
  extend ActiveSupport::Concern

  included do
  end

  # The default values are 'created_at' and true for descending, resulting in most recently created first.
  # This is overridden either by setting :sort and :desc on the Template instance or by providing
  # sort= and desc= query parameters. These query parameters take precedence.
  def entities_order(default = @template.default_api_order)
    if params[:sort] && ['created_at', 'updated_at', 'published_at'].include?(params[:sort])
      # If params[:desc] is 'true', nil or anything other than 'false', returns :desc by default
      {params[:sort] => (params[:desc] == 'false' ? :asc : :desc)}
    elsif params[:sort] && @template.dynamic_attributes.include?(params[:sort])
      # If params[:desc] is 'false', nil or anything other than 'true', returns :asc by default
      "(data -> '#{params[:sort]}') #{params[:desc] == 'true' ? 'DESC' : 'ASC'}"
      # Know that `-->` exists and casts JSON to text if needed.
    else
      default
    end
  end
end