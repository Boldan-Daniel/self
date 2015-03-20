class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin

  def authenticate_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def current_admin
    current_user
  end
  helper_method :current_admin
end