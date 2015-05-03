class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_numericality_of :hours, greater_than_or_equal_to: 0, less_than_or_equal_to: 12
  validates_numericality_of :minutes, greater_than_or_equal_to: 0, less_than: 60

  before_create :update_amount
  before_update :update_amount

  include Aggregate

  def user_project
    @user_project ||= UserProject.find_by_user_id_and_project_id user_id, project_id
  end

  def current_rate
    if user_project.present? && user_project.payable?
      user_project.current_rate
    elsif user.payable?
      user.current_rate
    end
  end

  private
  def update_amount
    self.amount = compute_amount
  end
end
