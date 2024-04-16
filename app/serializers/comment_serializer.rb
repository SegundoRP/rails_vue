class CommentSerializer
  include JSONAPI::Serializer
  attributes :body, :feature_id
end
