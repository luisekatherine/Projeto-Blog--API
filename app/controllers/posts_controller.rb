class PostsController < ApplicationController
    before_action :authorized, except: [ :index, :show ]
    before_action :set_post, only: [ :show, :update, :destroy, :link_tag, :unlink_tag, :tags_view ]
    before_action :set_tag, only: [ :link_tag ]
    before_action :render_not_authorized, only: [ :update, :destroy, :link_tag, :unlink_tag ]

    #GET / POSTS
    def index
        @posts = Post.all
    end

    #POST /posts
    def create
        @post = Post.new(post_params) #ou essa linha pode ficar assim: 
                                        #@post = Post.new(post_params.merge!(user_id: @user.id))
        @post.user = @user
        @post.save!
        render action: :show, status: :created
    end

    #GET/show/:id
    def show
    end

    #PUT/PATCH /posts:id
    def update
        @post.update(post_params)
        render action: :show, status: :ok
    end

    #DELETE
    def destroy
        @post.destroy
        head :no_content
    end

    #POST /posts/:id/tag
    def link_tag
        @post.tags.push(@tag)
        @tags = @post.tags
        render json: @post.tags, status: :ok
    end

    #DELETE /posts/:id/tag
    def unlink_tag
        @tag = @post.tags.find(params[:tag_id])
        @post.tags.delete(@tag)
        render json: @post.tags, status: :ok
    end

    #GET/ posts/:id/tags
    def tags_view
        @tags = @post.tags
        render json: @post.tags, status: :ok
    end

    private

    def post_params
        params.require(:post).permit(:title, :description)
    end

    def tag_params
        params.require(:post).permit(:tag_id, tag_id:[])
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def set_tag
        case params[:action]
        when 'link_tag'
            @tag = Tag.find(tag_params[:tag_id])
                when 'unlink_tag'
            @tag = @post.tags.find(tag_params[:tag_id])
        end
    end

    #se for autorizado, o usuário pode fazer as seguintes
    def authorized?
        @user == @post.user
    end
end