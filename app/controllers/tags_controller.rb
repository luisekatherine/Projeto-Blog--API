class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :update, :destroy]

    # GET /posts
    def index
        if params[:name].present?
            @tags = Tag.starting_with(params[:name])
        else
            @tags = Tag.all()
        end
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            render json: @tag, status: :created
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
    end

    #GET/show/:id
    def show
    end

    def update
        if @tag.update(tag_params)
            render action: :show, status: :ok
        else
            render json: @tag.errors, status: :unprocessable_entity
        end
      end

      #DELETE
    def destroy
        @tag.destroy
        head :no_content
    end

    private

    def tag_params
        params.require(:tag).permit(:name)
    end

    def set_tag
        @tag = Tag.find(params[:id])
    end
end

