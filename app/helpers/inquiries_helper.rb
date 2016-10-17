module InquiriesHelper
  def inquiry_form_header(request_type)
    I18n.t "inquiry.form.header.#{request_type}"
  end
end
