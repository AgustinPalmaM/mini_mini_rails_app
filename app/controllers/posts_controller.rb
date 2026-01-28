require_relative "base_controller"
require_relative "../models/post"
# posts_controller.rb
class PostsController < BaseController
  def index
    posts = Post.all
    render "posts/index", posts: posts
  end

  def create
    Post.create(params)
    response.status = 201
    response.write "post creado"
  end

  def update
    respond("PUT posts#update")
  end

  def destroy
    response.status = 204
  end

  private

  def respond(text)
    [200, { "content-type" => "text/plain; charset=utf-8" }, ["#{text}\n"]]
  end
end
