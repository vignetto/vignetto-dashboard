ActiveAdmin.register Payment do
  permit_params do
    params = [:user_id, 
              :event_id, 
              :event_date_id, 
              :tickets, 
              :ticket_price,
              :full_name, 
              :amount, 
              :stripe_charge_id, 
              :stripe_email, 
              :description, 
              :statement_descriptor, 
              :status, 
              :paid, 
              :refunded,
              :card_brand, 
              :card_four,
              :card_token, 
              :card_exp,
              :address, 
              :city, 
              :state, 
              :zipcode ]  
  end
  filter :user
  filter :event

  index do
    if current_user.admin?
      selectable_column
    end
    id_column if current_user.admin?
    column :stripe_charge_id
    column :full_name
    column :status
    column :paid
    column :refunded
    column :description
    column :tickets
    column('Price'){|p| p.to_currency(p.ticket_price)}
    column('Total', :amount){|p| p.get_amount_to_currency}
    column('Card', :card_brand)
    column('Last 4', :card_four)
    column('Exp', :card_exp)
    column('Email', :stripe_email)
    column :created_at                        
    actions
  end

  show do 
    tabs do
      tab 'Payment' do  
        attributes_table do
          row :id
          row :stripe_charge_id
          row('stripe'){|p| link_to "Stripe Payment...", "https://dashboard.stripe.com/test/payments/#{p.stripe_charge_id}", target: "_blank"}
          row('tickets'){|p| status_tag p.tickets, :no}
          row('paid'){|e| e.paid ? status_tag("YES") : status_tag("NO") }
          row('refunded'){|e| e.refunded ? status_tag("YES") : status_tag("NO") }
          row('price per ticket'){|p| status_tag p.to_currency(p.ticket_price), :green}
          row('total'){|p| status_tag p.get_amount_to_currency, :green}
          row('user'){|p| link_to p.user.get_name_or_email, admin_user_path(p.user)}   
          row('event'){|p| link_to p.event.title, admin_event_path(p.event)}
          row('event date'){|p| p.event_date.get_event_duration_format }         
          row :created_at                        
          row :updated_at  
        end
      end
      tab 'Credit Card' do  
        attributes_table do
          row :full_name
          row :card_brand
          row('Last 4'){|p| "**** #{p.card_four}"}
          row :card_exp
          row('card address'){|p| "#{p.address}. #{p.city}, #{p.state} #{p.zipcode}"}
        end
      end
      tab 'Stripe Information' do  
        attributes_table do
          row :stripe_charge_id
          row :status
          row :stripe_email
          row :description
          row :statement_descriptor
        end
      end
    end
  end
end