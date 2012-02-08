class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index,:edit,:update,:destroy]
    before_filter :corrent_user, :only => [:edit,:update]
    before_filter :admin_user,   :only => :destroy

    def index
        @title = "All Users"
        @users = User.paginate(:page => params[:page])
    end

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def new
	   @user  = User.new
	   @title = "Sign up"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
		  #保存成功处理方式	
		  sign_in @user
		  flash[:success] = "Welcom to the Sample App!"
		  redirect_to @user
		else
		  @title = "Sign up"
		  render 'new'	
		end
	end

	def edit
		#@user = User.find(params[:id]) 移除到corrent_user 的过滤器方法中
		@title = "Edit User"
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			@title = "Edit User"
			render 'edit'
		end				
	end

	def destroy
		puts("-1111--------------------------------------------------------")
		User.find(params{:id}).destroy
		puts("--2222-------------------------------------------------------")
		flash[:success] = "User Destroyed"
		redirect_to users_path
	end

	private
		def authenticate
			deny_access unless signed_in? #deny_access 方法定义在SessionHelper中
		end
		def corrent_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user) #current_user 方法定义在SessionHelper中
		end
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

end
