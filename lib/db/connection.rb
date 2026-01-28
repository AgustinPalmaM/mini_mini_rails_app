require "pg"

module DB
  class Connection
    def self.connection
      @connection ||= PG.connect(
        host: ENV.fetch("DB_HOST"),
        dbname: ENV.fetch("DB_NAME"),
        user: ENV.fetch("DB_USER"),
        password: ENV.fetch("DB_PASSWORD"),
      )
    end

    def self.exec(sql, params = [])
      connection.exec_params(sql, params)
    end
  end
end
