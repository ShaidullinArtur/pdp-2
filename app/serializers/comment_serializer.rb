class CommentSerializer < ApplicationSerializer
  attributes :id, :text, :created_at

  belongs_to :author
end
