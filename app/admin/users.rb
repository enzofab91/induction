ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :gender, :reset_password_token, :reset_password_sent_at, :remember_created_at, :provider, :uid, :tokens, :confirmation_token, :confirmed_at, :confirmation_sent_at, :targets_count, :first_name, :last_name, :push_token, :allow_password_change
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :gender, :reset_password_token, :reset_password_sent_at, :remember_created_at, :provider, :uid, :tokens, :confirmation_token, :confirmed_at, :confirmation_sent_at, :targets_count, :first_name, :last_name, :push_token, :allow_password_change]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
