

# ActiveRecord::Base.establish_connection(
#     :adapter  => ENV["DB_ADAPTER"],
#     :host     => ENV["DB_HOST"],
#     :port     => ENV["DB_PORT"],
#     :username => ENV["ACME_DB_USER"],
#     :password => ENV["ACME_DB_PASSWORD"],
#     :database => ENV["ACME_DBNAME"],
#     :pool => 10
# )


class UssdRequest < ActiveRecord::Base

end

class LoanRequests < ActiveRecord::Base
  self.table_name = "loan_requests"
end

class MoreHelper < ActiveRecord::Base
end

class PaymentInfo < ActiveRecord::Base
  self.table_name = "payment_info"
end

class Tracker < ActiveRecord::Base

  self.table_name = "ussd_trackers"

  def self.find_previous_session(mobile_number)
    activity_type = TrackerActivityTemp.where(mobile_number: mobile_number).order('id desc').pluck(:activity_type)[0]
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    resultset = where(mobile_number: mobile_number, previous_tracker: false, service_code: service_code).order('id desc').limit(2)
    puts "RESULT SET FOR PREVIOUS SESSION: #{resultset.last.inspect}"
    resultset.last
  end


  def self.find_previous_three_session(mobile_number)
    # activity_type = TrackerActivityTemp.where(mobile_number: mobile_number).order('id desc').pluck(:activity_type)[0]
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    resultset = where(mobile_number: mobile_number, previous_tracker: false, service_code: service_code).order('id desc').limit(3)
    puts "RESULT SET FOR PREVIOUS SESSION: #{resultset.last.inspect}"
    resultset.last
  end


  def self.recent_previous_session(mobile_number)
    # activity_type = TrackerActivityTemp.where(mobile_number: mobile_number).order('id desc').pluck(:activity_type)[0]
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    resultset = where(mobile_number: mobile_number, previous_tracker: false, service_code: service_code).order('id desc').limit(2)
    puts "RESULT SET FOR RECENT PREVIOUS SESSION: #{resultset.first.inspect}"
    resultset.first
  end

  def self.new_tracker(session_id, mobile_number)
    activity_type = TrackerActivityTemp.where(mobile_number: mobile_number).order('id desc').pluck(:activity_type)[0]
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    where(session_id: session_id, previous_tracker: true).order('id desc').first
  end


  def self.delete_previous_trackers(mobile_number)
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    sql = "DELETE FROM ussd_trackers WHERE mobile_number = '#{mobile_number}' AND  service_code = '#{service_code}' AND previous_tracker = true"
    Tracker.connection.execute(sql)
  end

  def self.delete_trackers_activitytypes(mobile_number,activity_type)
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    sql = "DELETE FROM ussd_trackers WHERE mobile_number = '#{mobile_number}' and service_code = '#{service_code}' "
    Tracker.connection.execute(sql)
  end

end



class TrackerActivityTemp < ActiveRecord::Base

  self.table_name = "ussd_tracker_activity_temps"

  def self.recent_activity_type(mobile_number)
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    activity_type = TrackerActivityTemp.where(mobile_number: mobile_number, service_code: service_code).order('id desc').pluck(:activity_type)[0]
    activity_type
  end

  def self.service_activity_name(mobile_number)
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    service_label = TrackerActivityTemp.where(mobile_number: mobile_number, service_code: service_code).order('id desc').pluck(:service_label)[0]
    service_label
  end

  def self.recent_activty_menu(mobile_number)
    service_code = UssdServiceCode.recent_dialed_servicecode(mobile_number)
    service_label = TrackerActivityTemp.where(mobile_number: mobile_number, service_code: service_code).order('id desc').pluck(:activity_type_menu)[0]
    service_label
  end

end


class LovTemp < ActiveRecord::Base

  self.table_name = "ussd_lov_temps"

  def self.get_lov_id_desc(mobile_number, lov_index)
      lov_temps_results = where(mobile_number: mobile_number, lov_index: lov_index).order('id desc')[0]
      result1 = lov_temps_results["lov_id"], lov_temps_results["lov_desc"], lov_temps_results["assigned_amount"]
      result1
  end

  def self.destroy_temps(mobile_number,entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end


class LovTempTemp < ActiveRecord::Base

  self.table_name = "ussd_lov_temp_temps"

  def self.get_lov_id_desc(mobile_number, lov_index)
      lov_temps_results = where(mobile_number: mobile_number, lov_index: lov_index).order('id desc')[0]
      result1 = lov_temps_results["lov_id"], lov_temps_results["lov_desc"]
      result1
  end

  def self.destroy_temps(mobile_number,entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end



class MerchantHistoryTemp < ActiveRecord::Base

  self.table_name = "ussd_merchant_mini_history_temps"

  def self.get_id_desc(mobile_number, record_index)
      temps_results = where(mobile_number: mobile_number, record_index: record_index).order('id desc')[0]
      result1 = temps_results["mobile_number"], temps_results["customer_number"], temps_results["amount"], temps_results["status"], temps_results["trans_date"]
      result1
  end

  def self.destroy_temps(mobile_number)
    where(mobile_number: mobile_number).destroy_all
  end

end



class ActivityPlanTemp < ActiveRecord::Base

  self.table_name = "ussd_activity_plans_temps"

  def self.get_activity_plan_id_desc(mobile_number, activity_plan_index)
    activity_plan_temps_results = where(mobile_number: mobile_number, activity_plan_index: activity_plan_index).order('id desc')[0]
    if !activity_plan_temps_results.nil?
      result1 = activity_plan_temps_results["activity_plan_id"], activity_plan_temps_results["activity_plan"], activity_plan_temps_results["activity_date"]
      return result1
    else
      return false
    end

  end

  def self.destroy_activity_plan_temps(mobile_number)
    activity_plan_temps = where(mobile_number: mobile_number)
    activity_plan_temps.each {|tracker| tracker.destroy}
  end

end




class ActivitySubPlanTemp < ActiveRecord::Base

  self.table_name = "ussd_activity_sub_plans_temps"

  def self.get_subplan_desc(mobile_number, activity_sub_plan_index)
    temp_results = where(mobile_number: mobile_number, activity_sub_plan_index: activity_sub_plan_index).order('id desc')[0]
    result1 = temp_results["activity_sub_plan_id"], temp_results["activity_date"], temp_results["activity_time"], temp_results["classification"], temp_results["price"], temp_results["max_ticket_reached"], temp_results["max_num_ticket"], temp_results["ticket_count"]
    result1
  end

  def self.destroy_sub_activity_plan_temps(mobile_number, entity_div_code)
    activity_sub_plan_temps = where(mobile_number: mobile_number, entity_div_code: entity_div_code)
    activity_sub_plan_temps.each {|tracker| tracker.destroy}
  end

end

class ActivityDivCatTemp < ActiveRecord::Base

  self.table_name = "ussd_activity_div_cat_temps"

  def self.get_activity_divcat_id_desc(mobile_number, activity_div_cat_index)
    temp_results = where(mobile_number: mobile_number, activity_div_cat_index: activity_div_cat_index).order('id desc')[0]
    result1 = temp_results["activity_div_cat_id"], temp_results["activity_div_category"], temp_results["entity_div_code"]
    result1
  end

  def self.destroy_temps(mobile_number,entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end

class ActivityDivSubCatTemp < ActiveRecord::Base

  self.table_name = "ussd_activity_div_sub_cat_temps"

  def self.get_activity_divsubcat_id_desc(mobile_number, activity_cat_div_id_index)
    temp_results = where(mobile_number: mobile_number, activity_div_subcat_index: activity_cat_div_id_index).order('id desc')[0]
    result1 = temp_results["activity_cat_div_id"], temp_results["category_div_desc"], temp_results["entity_div_code"]
    result1
  end

  def self.destroy_temps(mobile_number,entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end


class ActivityFixturesTemp < ActiveRecord::Base

  self.table_name = "ussd_activity_fixtures_temps"

  def self.get_fixtures_id_desc(mobile_number, fixtures_index)
    temp_results = where(mobile_number: mobile_number, fixtures_index: fixtures_index).order('id desc')[0]
    result1 = temp_results['activity_code'],temp_results["activity_category_div"], temp_results["activity_fixture_id"], temp_results["participant_a_alias"],temp_results["participant_a"],temp_results["participant_b_alias"], temp_results["participant_b"], temp_results["entity_div_code"]
    result1
  end

  def self.destroy_temps(mobile_number, entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end


class UssdServiceCode < ActiveRecord::Base

  self.table_name = "ussd_service_codes"

  def self.get_lov_id_desc(mobile_number, lov_index)
    lov_temps_results = where(mobile_number: mobile_number, lov_index: lov_index).order('id desc')[0]
    result1 = lov_temps_results["lov_id"], lov_temps_results["lov_desc"]
    result1
  end

  def self.recent_dialed_servicecode(mobile_number)
    latest_service_code = where(mobile_number: mobile_number).order('id desc').pluck(:service_code)[0]
    latest_service_code
  end

end


class MoreAlgo < ActiveRecord::Base
  self.table_name = "ussd_more_algos"
end

class EntityAdminWhitelist < ActiveRecord::Base
  self.table_name = "entity_admin_whitelist"
  self.primary_key = "id"
end

class NotificationRecipient < ActiveRecord::Base
  self.table_name = "notification_recipient"
  self.primary_key = "id"
end

class EventTemp < ActiveRecord::Base
  self.table_name = "ussd_event_temps"
  self.primary_key = "id"

  def self.destroy_temps(mobile_number,service_code)
    where(mobile_number: mobile_number, service_code: service_code).destroy_all
  end


  def self.fetch_details(mobile_number,service_code, event_index)
    temps_results = where(mobile_number: mobile_number, service_code: service_code, event_index: event_index ).order('id desc')[0]
    result1 = temps_results["activity_type"], temps_results["entity_div_code"], temps_results["service_label"], temps_results["allow_qr"]
    result1
  end

end


class DivSubActivityTemp < ActiveRecord::Base
  self.table_name = "ussd_div_sub_activity_temps"

  def self.fetch_details(mobile_number, service_code, activity_index)
    temps_results = where(mobile_number: mobile_number, service_code: service_code, activity_index: activity_index ).order('id desc')[0]
    result1 = temps_results["activity_code"], temps_results["sub_activity_desc"]
    result1
  end

  def self.destroy_temps(mobile_number,entity_div_code)
    where(mobile_number: mobile_number, entity_div_code: entity_div_code).destroy_all
  end

end



class CartTemp < ActiveRecord::Base
  self.table_name = "ussd_cart_temps"

  # def self.fetch_details(mobile_number, service_code, activity_index)
  #   temps_results = where(mobile_number: mobile_number, service_code: service_code, activity_index: activity_index ).order('id desc')[0]
  #   result1 = temps_results["activity_code"], temps_results["sub_activity_desc"]
  #   result1
  # end

  def self.destroy_temps(session_id)
    where(session_id: session_id).destroy_all
  end

end


#CONTINUE FROM WHERE YOU LEFT OFF --> WORKS
class CurrentTracker < ActiveRecord::Base
  self.table_name = "ussd_current_trackers"
end
