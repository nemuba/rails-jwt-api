module Api
  module V1
    class LikesController < ApiController
      before_action :authorize_request
      before_action :set_post
      before_action :set_like, only:[:destroy]

      def create
        @like = @post.likes.new(user: current_user)

        if @like.save
          render json: {success: "ok"}, status: :ok
        else
          render json: @like.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @like.destroy
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def set_like
        @like = Like.find_by(user: current_user, post: @post)
        @like
      end
    end
  end
end
