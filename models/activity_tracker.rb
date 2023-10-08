# frozen_string_literal: true

class ActivityTracker < ActiveRecord::Base
    self.table_name = "ussd_tracker_activity_temps"
end
