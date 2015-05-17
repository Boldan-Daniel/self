module Admin
  class UsersController < BaseController

    respond_to :html
    respond_to :js, only: [ :add_rate, :add_project ]

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Users', :admin_users_path

    def index
      @users = User.all
    end

    def edit
      @user = User.find params[:id]
      unless @user.payable?
        flash.now[:alert] = "#{@user.name} does not have a base rate. Please add one."
      end

      add_breadcrumb "Editing User: #{@user.name}", edit_admin_user_path(@user.id)
    end

    def add_rate
      @rate = Rate.new add_rate_params
      @success = @rate.save
      respond_with @rate, location: edit_admin_user_path(add_rate_params[:payable_id])
    end

    def add_project
      @user = User.find params[:id]
      @user_project = @user.user_projects.new add_project_params
      @success = @user_project.save
      respond_with @user_project, location: -> { edit_admin_user_path @user_project.user }
    end

    def remove_project
      UserProject.where(project_id: params[:project_id], user_id: params[:id]).destroy_all
      flash[:notice] = 'Project successfully removed'
    rescue
      flash[:alert] = 'Unable to remove project'
    ensure
      redirect_to action: :edit, id: params[:id]
    end

    private
    def add_project_params
      rates_attributes = [ :hourly_rate, :hourly_rate_ot, :available_from, :available_until ]
      params.require(:user_project).permit(:project_id, rates_attributes: rates_attributes)
    end

    def add_rate_params
      params.require(:rate).permit :payable_id, :payable_type, :available_from,
                                   :available_until, :hourly_rate, :hourly_rate_ot
    end
  end
end