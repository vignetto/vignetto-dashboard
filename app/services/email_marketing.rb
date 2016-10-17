class EmailMarketing
  require 'gibbon'

  API_KEY = Rails.configuration.mailchimp[:mailchimp_key]
  MASTER_LIST = Rails.configuration.mailchimp[:mailchimp_master_list] 

  def self.subscribe_user_to_master(email, name='')
    client = Gibbon::Request.new(api_key: API_KEY)
    begin 
      result = client.lists(MASTER_LIST).members.create(body: {email_address: email, status: "subscribed", merge_fields: {ENV: Rails.env, NAME: name}})
      Rails.logger.info("MAILCHIMP SUBSCRIBE: #{email} to master list.") if result
    rescue Gibbon::MailChimpError => e
      Rails.logger.info("Mailchimp errors: #{e.to_s} for #{email}")
    end
  end
end
