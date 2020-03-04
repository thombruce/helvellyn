class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /blogs/:blog_id/posts
  # GET /blogs/:blog_id/posts.json
  def index
    @posts = policy_scope(current_blog.posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /blogs/:blog_id/posts/new
  def new
    @post = current_blog.posts.build(user: current_user)
    authorize @post
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /blogs/:blog_id/posts
  # POST /blogs/:blog_id/posts.json
  def create
    @post = current_blog.posts.build(permitted_attributes(Post).merge(user: current_user))
    authorize @post

    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(permitted_attributes(@post))
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      authorize @post
    end
end
