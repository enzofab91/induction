ActiveAdmin.register Contact do
  index do
    selectable_column
    id_column
    column :body
    column :email
    column :created_at
    column :updated_at
    actions
  end
end
