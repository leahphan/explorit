class PostsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :destroy]
	before_filter :prepare_categories

	def index
		if params[:search]
			@posts = Post.search(params[:search])
		elsif params[:category_id]
			@posts = Post.where(:category_id => params[:category_id])
		else
			@posts = Post.all
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
		@categories = Category.all
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post edited!"
			redirect_to post_path
		else
			render 'edit'
		end
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
		post = Post.find(params[:id]).destroy
		flash[:notice] = "Post deleted"
		redirect_to user_path
	end

	private

		def post_params
			params.require(:post).permit(:title, :description, :photo, :category_id, :new_category)
		end

		def prepare_categories
			@categories = Category.all
		end
end