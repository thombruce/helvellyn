class Admin::SettingsController < AdminController
  before_action :set_settings

  def show
  end

  def public
  end

  def edit
  end

  def update
    if @settings.update(permitted_attributes(@settings))
      render :show, status: :ok, location: settings_path
    else
      render json: @settings.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_settings
      @settings = Settings.instance
      authorize @settings
    end
end
