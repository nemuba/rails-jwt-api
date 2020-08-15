module Api
  module V1
    class CommentsController < ApiController
      before_action :authorize_request
      before_action :set_comment, only: [:show, :update, :destroy]
      before_action :set_post, only: [:create]
    
      # GET /comments
      def index
        @comments = Comment.all
    
        render json: @comments
      end
    
      # GET /comments/1
      def show
        render json: @comment
      end
    
      # POST /comments
      def create
        
        @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    
        if @comment.save
          render json: @comment, status: :created, location: api_v1_post_comment_path(@post, @comment)
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /comments/1
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /comments/1
      def destroy
        @comment.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_post
          @post = Post.find(params[:post_id])
        end
        
        def set_comment
          @comment = Comment.find(params[:id])
        end
    
        # Only allow a trusted parameter "white list" through.
        def comment_params
          params.require(:comment).permit(:description, :post_id, :user_id)
        end
    end
    
  end
end