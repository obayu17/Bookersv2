class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_user, only: [:edit, :update]

	def index
		@users = User.all
		@book = Book.new
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = @user.books
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user), notice: "successfully update user!!"
		else
			redirect_to user_path(@user), notice: "error!!"
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end

	def ensure_user
  		unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  		end
    end
end
