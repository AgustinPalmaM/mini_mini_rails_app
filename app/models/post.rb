require_relative "../../lib/db/connection"

class Post
  attr_reader :id, :title, :body

  def initialize(attrs = {})
    @id = attrs["id"]
    @title = attrs["title"]
    @body = attrs["body"]
  end

  def self.all
    result = DB::Connection.exec("SELECT * FROM posts ORDER BY id")
    result.map { |row| new(row) }
  end

  def self.create(attrs)
    result = DB::Connection.exec(
      "INSERT INTO posts (title, body) VALUES ($1, $2) RETURNING *",
      [attrs["title"], attrs["body"]]
    )
    new(result.first)
  end
end
