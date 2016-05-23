ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
      tabs do
        tab 'Overview' do
          attributes_table do
            row :id
            row :username
            row :email
            row :newsletter
            row :sign_in_count
            row :reset_password_sent_at
            row :current_sign_in_at
            row :last_sign_in_at
            row :created_at
            row :updated_at
          end
        end

        tab 'Teas' do
          table_for user.teas do
            column :name
            column :favorite
            column :stock
            column :archive
            column :vendor
            column :url
            column :notes
          end
        end

        tab 'Wishlist' do
          table_for user.wishlists do
            column :name
            column :url
            column :notes
          end
        end

        tab 'Notes' do
          table_for user.notes do
            column :title
            column :body
          end
        end

        tab 'Attributes' do
          table_for user.atts do
            column :name
          end
        end
      end
    end
end
