require 'active_support/concern'

module Aggregate
  extend ActiveSupport::Concern

  included do
    scope :at, ->(d) { where(worked_at: d) }
  end

  def duration
    hours.hours + minutes.minutes
  end

  def duration_in_hours
    duration / 3600.0
  end

  def compute_amount
    rate = current_rate
    hourly_rate = ot? ? rate.hourly_rate_ot : rate.hourly_rate rescue 0

    hourly_rate * duration_in_hours
  end

  class_methods do
    def total
      sum(:hours).hours + sum(:minutes).minutes
    end

    def total_amount
      sum(:amount)
    end
  end
end