ActiveAdmin.register Booking do

  form do |f|
    f.inputs do
      f.input :start, :as => :datetime, :value => DateTime.now
      f.input :end, :as => :datetime
      f.input :user, :allow_destroy => false, :new_record => false
      f.input :machine, :allow_destroy => false, :new_record => false
    end
    f.actions
  end

  index do
    column :user
    column :machine
    column :start
    column :end
    default_actions
  end

  permit_params :start, :end, :user_id, :machine_id

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
