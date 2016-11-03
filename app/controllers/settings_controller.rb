class SettingsController < ApplicationController
    authorize_resource

    def index
      @settings = Setting.get_all
    end

    def update
      @setting = Setting.find_by(var: params[:format]) || Setting.new(var: params[:format])
      if @setting.value != params[:setting][:value]
        @setting.value = params[:setting][:value]
        @setting.save!
        redirect_to settings_path, notice: 'Setting has updated.'
      else
        redirect_to settings_path
      end
    end
end