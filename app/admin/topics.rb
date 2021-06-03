ActiveAdmin.register Topic do
  permit_params :name, :image

  form do |f|
    f.input :name
    f.input :image, as: :file
    actions
  end
end
