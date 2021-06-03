ActiveAdmin.register Target do
  actions :all, except: %i[new edit]

  index do
    selectable_column
    id_column
    column :title
    column :radius
    column :latitude
    column :longitude
    column :created_at
    column :updated_at
    column :user
    column :topic
    actions
  end
end
