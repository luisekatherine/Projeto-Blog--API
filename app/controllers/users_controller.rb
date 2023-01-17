class UsersController < ApplicationController
  include BCrypt
  #before_action :set_user, only: %i[ edit update destroy ]
  before_action :set_user, only: %i[ show ]
  before_action :authorized, only: %i[ update destroy auto_login ]

  # GET /users or /users.json
  # def index
  #   @users = User.all
  # end

  # GET /auto_login
  def auto_login
    render :show
  end

  #GET/show/:id
  def show
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # # GET /users/1/edit
  # def edit
  # end

  #POST /user
  def create
    @user = User.new(user_params)
    @user.save!
    @token = encode_token({user_id: @user.id})
    render :show, status: :created
    end

  # REGISTER
  # def create
  #   @user = User.create(user_params)
  #   if @user.valid?
  #     token = encode_token({user_id: @user.id})
  #     render json: {user: @user, token: token}
  #   else
  #     render json: {error: "Invalid username or password"}
  #   end
  # end

    # LOGGING IN
    #POST /login
    def login
      @user = User.find_by(email: params[:email])
  
      if @user && @user.authenticate(params[:password])
        @token = encode_token({user_id: @user.id})
        render :show
      else
        render json: {error: "Invalid username or password"}
      end
    end
  
    def auto_login
      render json: @user
    end

  # PATCH/PUT /user
  def update
    @user.update!(user_params)
    render :show, status: :ok
  end
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /user
  def destroy
    @user.destroy
    head :no_content
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def user_params
    #   params.require(:user).permit(:name, :email)
    # end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
