class CommentsController < ApplicationController
    before_action :authorized, except: [:show, :index]
    before_action :set_post
    before_action :set_comment, only: [:show, :update, :destroy]
    before_action :render_not_authorized, only: [ :update, :destroy ]
    

    #GET / POSTS
    def index
        @comments = @post.comments
    end

    
    #POST /posts
    def create
        @comment = @post.comments.new(comment_params)
        @comment.user = @user
        @comment.save!
        render action: :show, status: :created
    end

    #GET/show/:id
    def show
    end

    #PUT/PATCH /posts:id
    def update
        if @comment.update(comment_params)
            render action: :show, status: :ok
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    #DELETE
    def destroy
        @comment.destroy
        head :no_content
    end

    private

    def comment_params
        params.require(:comment).permit(:text)
    end

    def set_comment
        @comment = @post.comments.find(params[:id])
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def authorized?
        if params[:action] == 'update'
            @user == @comment.user
        elsif params[:action] == 'destroy'
            @user == @comment.user || @user == @comment.post.user
        end
    end
end
