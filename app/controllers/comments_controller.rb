# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
    def index
      @film = Film.find(params[:film_id])
      @comments = @film.comments.order(created_at: :desc)
    end
  
    def create
      @film = Film.find(params[:film_id])
      @comment = @film.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        redirect_to film_path(@film)
      else
        # Handle the error, e.g., render the film show page with an error message
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  