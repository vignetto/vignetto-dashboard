ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
        column do
            panel "Recent Published Events" do
              ul do
                Event.published.recent(10).map do |event|
                  li link_to("#{event.title} created #{event.created_at}", admin_event_path(event))
                end
              end
            end
        end
        column do
            panel "Recent Unpublished Events" do
              ul do
                Event.unpublished.recent(10).map do |event|
                  li link_to("#{event.title} created #{event.created_at}", admin_event_path(event))
                end
              end
            end
        end
    end
    columns do
        column do
            panel "Recent Inquiries" do
              ul do
                Inquiry.recent(10).map do |inquiry|
                  li link_to("#{inquiry.request_type.titleize} from #{inquiry.email} on #{inquiry.created_at}", admin_inquiry_path(inquiry))
                end
              end
            end
        end
    end
  end # content
end
