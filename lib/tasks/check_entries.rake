namespace :temp_graph do
  desc "Checks to see if there are sensors that aren't responding, alerts if there are."
  task :check_entries => :environment do

    def perform
      names = Sensor.not_reporting.pluck(:friendly_name)
      unless names.blank?
        TwilioWrapper.send_message("+15038515506", "No data reported from the following #{'sensor'.pluralize(names.count)}: #{names.join(', ')}.")
        #TODO: store the timestamp of when a sensor was not reporting data.
      end
    end


    perform
  end
end
