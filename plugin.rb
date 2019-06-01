# name: discourse-modify-email-header
# about: A plugin to modify email headers
# version: 0.1
# authors: Osama Sayegh
# url: https://github.com/OsamaSayegh/discourse-modify-email-header

after_initialize do
  class Email::MessageBuilder
    old_method = instance_method(:alias_email)
    define_method(:alias_email) do |source|
      if @opts[:username].present? && @opts[:from_alias].present? && SiteSetting.custom_text_in_emails_from_header.presence
        @opts[:from_alias] = "#{@opts[:username]} #{SiteSetting.custom_text_in_emails_from_header}"
      end
      old_method.bind(self).(source)
    end
  end
end
