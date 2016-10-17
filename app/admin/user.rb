ActiveAdmin.register User do
  permit_params do
    params = [:name,
              :email,
              :password,
              :password_confirmation,
              :address,
              :city,
              :state,
              :zipcode,
              :phone ]
    params << :role if current_user.may_assign_roles?
    params
  end

  index do
    if current_user.admin?
      selectable_column
    end
    id_column if current_user.admin?
    column "Name" do |u|
      link_to u.get_name_or_email, admin_user_path(u)
    end
    column :role do |u|
      u.role.titleize
    end
    column :address
    column :city
    column :state
    column :zipcode
    column :phone
    column :email
    column :phone
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :role, as: :select, collection: User::roles
  
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "User Details" do
      f.input :role, as: :select, collection: User::roles.map{|r| [r.first, r.first] }, include_blank: false
      f.input :name
      f.input :email, as: :email
      f.input :phone, input_html: { :maxlength => 12 }
      f.input :address
      f.input :city
      f.input :state, input_html: { :maxlength => 2 }, hint: "State Abbreviation"
      f.input :zipcode, input_html: { :maxlength => 5 }
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row "role" do |u|
        status_tag u.role, :no
      end
      row :name
      row :email
      row :phone
      row :address
      row :city
      row :state
      row :zipcode
      row :created_at
      row :updated_at
    end
  end
end
