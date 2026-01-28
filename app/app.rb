require_relative "../config/router"
require_relative "controllers/posts_controller"

class App
  def initialize
    @router = Router.new

    @router.get "/posts", to: "posts#index"
    @router.post "/posts", to: "posts#create"
    @router.put "/posts", to: "posts#update"
    @router.delete "/posts", to: "posts#destroy"
  end

  def call(env)
    @router.call(env)
  end
end
