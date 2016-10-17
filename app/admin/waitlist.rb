ActiveAdmin.register Waitlist do
  permit_params do
    params = [:event_id, :event_date_id, :limit, :total_users, :active, :add_user, :remove_user] 
  end

  after_save do |waitlist|
    waitlist.add_user_to_waitlist(params[:waitlist][:add_user]) unless params[:waitlist][:add_user].blank?
    waitlist.remove_user_from_waitlist(params[:waitlist][:remove_user]) unless params[:waitlist][:remove_user].blank?
  end

  index do
    if current_user.admin?
      selectable_column
    end
    id_column if current_user.admin?
    column('Event') {|w| w.event.title}
    column('Event Date') {|w| w.event_date.get_event_duration_format}                                  
    column :limit
    column('Total', :total_users)
    column('Active') {|w| w.active ? (status_tag 'ACTIVE', :green) : (status_tag 'NO')}                                 
    column('Full') {|w| w.full_waitlist? ? (status_tag 'FULL', :red) : (status_tag 'NO')}                                 
    column :created_at                        
    column :updated_at 
    actions
  end

  filter :event_id, as: :select, collection: proc { policy_scope(Event).all.map{|e| [e.title, e.id]} }
  filter :active

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Waitlist Details' do      
      f.input :event_date_id, as: :select, collection: policy_scope(EventDate).all.map{|ed| ["#{ed.get_event_and_event_date_format} ", ed.id]}, include_blank: false 
      f.input :limit, hint: 'Allowed limit for this waitlist, users cannot be waitlisted once the limit is reached.'           
      f.input :total_users
      f.input :active
    end
    f.inputs 'Add User(s) to Waitlist' do      
      f.input :add_user, 
              as: :string, 
              hint: 'Enter user email or comma seperated email list. E.g.: "email1@example.com, email2@example.com, ..."',
              label: 'Add Registered User (email)'
    end
    unless f.object.new_record?
      f.inputs 'Remove User from Waitlist' do      
        if object.users.any?
          f.input :remove_user, as: :select, collection: f.object.users.map{|u| [u.email, u.id]}
        else 
          li "Empty"
        end  
      end
    end
    f.actions
  end

  show title: proc {|w| "Waitlist: #{w.event.title} - #{w.event_date.get_event_duration_format}"} do    
    attributes_table  do
      row :id
      row('Event') {|w| w.event.title}
      row('Event Date') {|w| w.event_date.get_event_duration_format}
      row :limit
      row :total_users 
      row('Active') {|w| w.active ? (status_tag 'ACTIVE', :green) : (status_tag 'NO')}                                 
      row('Full') {|w| w.full_waitlist? ? (status_tag 'FULL', :red) : (status_tag 'NO')}                                                               
      row :created_at                        
      row :updated_at                        
    end    
    panel "Users on Waitlist ( #{waitlist.users.size} )" do
      table_for waitlist.users do
        column("name") {|u| link_to u.name, admin_user_path(u)}
        column :email
        column :role
      end
    end
  end

  controller do
    def destroy
      if resource.users.empty?
        resource.event_date.remove_waitlist
        super
      else
        redirect_to collection_url, alert: "Waitlist cannot be deleted, NOT empty!" and return if resource.valid?
      end
    end
  end
end
