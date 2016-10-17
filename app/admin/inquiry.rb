ActiveAdmin.register Inquiry do

  permit_params do
    params = [:first_name,
              :last_name,
              :email,
              :phone,
              :notes,
              :request_type
            ]
    params
  end

  index do
    selectable_column
    id_column
    column :request_type do |r|
      r.request_type.titleize
    end
    column :first_name
    column :last_name
    column :email
    column :phone
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :request_type, as: :select, collection: Inquiry::request_types

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Inquiry Details" do
      f.input :request_type, as: :select, collection: Inquiry::request_types.map{|r| [r.first.titleize, r.first] }, include_blank: false
      f.input :first_name
      f.input :last_name
      f.input :email, as: :email
      f.input :phone, input_html: { :maxlength => 12 }
      f.input :notes
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row 'Request Type' do |r|
        r.request_type.titleize
      end
      row :first_name
      row :last_name
      row :email
      row :phone
      row :notes
      row :created_at
      row :updated_at
    end
  end

end
