ActiveAdmin.register About do
  actions :all, except: %i[delete]

  menu label: 'About'

  index do
    selectable_column
    id_column
    column :body
    actions
  end
end
