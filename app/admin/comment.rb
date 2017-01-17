ActiveAdmin.register Comment, as: "PostComment" do
  includes :author, :post

  permit_params :text

  index do
    id_column
    column :created_at
    column :text
    column :author do |post_comment|
      link_to(post_comment.author.full_name, admin_user_path(post_comment.author))
    end
    column :post do |post_comment|
      link_to(post_comment.post.title, admin_post_path(post_comment.post))
    end
    actions
  end

  filter :created_at
  filter :author
  filter :post

  show do
    panel t("formtastic.labels.details") do
      attributes_table_for(post_comment) do
        row :id
        row :created_at
        row :text
        row :author do |post_comment|
          link_to(post_comment.author.full_name, admin_user_path(post_comment.author))
        end
        row :post do |post_comment|
          link_to(post_comment.post.title, admin_post_path(post_comment.post))
        end
      end
    end
  end

  form do |f|
    f.inputs "Comment Details" do
      f.input :text
    end
    f.actions
  end
end
