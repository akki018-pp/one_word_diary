class ApplicationController < ActionController::Base
  helper_method :current_time_slot

  private

  def current_time_slot
    hour = Time.zone.now.hour
    case hour
    when 6..11 then "morning"
    when 12..17 then "afternoon"
    when 18..23 then "evening"
    else nil
    end
  end
end
