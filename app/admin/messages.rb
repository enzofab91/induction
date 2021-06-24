ActiveAdmin.register Message do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :conversation
    column :body
    column :created_at
    column :user
    actions
  end
end
