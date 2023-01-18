class LikesController < ApplicationController
    before_action :authorized #para verificar se há alguém logado
    before_action :set_post, only: [ :create_like_post ]
    before_action :set_post_like, only: [ :destroy_like_post ]
    before_action :set_comment_like, only: [ :destroy_like_comment ]
    before_action :set_comment, only: [ :create_like_comment ]
    before_action :set_like, only: [ :destroy_like_comment, :destroy_like_post ]
    before_action :render_not_authorized, only: [ :destroy_like_comment, :destroy_like_post  ] #verifica se o usuário que deu o like, vai tirar o like

    def create_like_post
        @like = Like.new(likeable: @post)
        @like.user = @user
        @like.save!
        render action: :show, status: :created
    end

    def destroy_like_post
        @like.destroy
        head :no_content
    end

    def create_like_comment
        @like = Like.new(likeable: @comment) # @like = @comment.likes.new(:likeable @comment, @like.user = user) para que o código fique mais compacto, aí tiramos as duas linhas de baixo.
        @like.user = @user
        @like.save!
        render action: :show, status: :created
    end

    def destroy_like_comment
        @like.destroy
        head :no_content
    end  

    private

    def set_comment
        @comment = Comment.find(params[:comment_id])
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_post_like
        @like = Post.find(params[:post_id]).likes.find_by(user_id: @user.id)
    end

    def set_comment_like
        @like = Comment.find(params[:comment_id]).likes.find_by(user_id: @user.id)
    end
    
    def authorized?
        @user == @like.user
    end
end
