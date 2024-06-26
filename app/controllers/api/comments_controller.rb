class Api::CommentsController < ApplicationController
  def create
    comment = Comment.build(comment_params)
    comment.feature_id = params[:feature_id].to_i unless params[:comment][:feature_id].present?

    if comment.save!
      render json: CommentSerializer.new(comment), status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :feature_id)
  end
end
