# frozen_string_literal: true

require "sequel"

module HathiTrust
  class Database
    # Not including `ht`
    ALL_DATABASES = [
      :hathifiles,
      :ht_maintenance,
      :ht_repository,
      :ht_rights,
      :ht_web
    ]

    def initialize
      @connections = {}
      connection
    end

    def connection
      connection_for :ht
    end

    def connection_for(database_name)
      database_name = database_name.to_sym
      @connections[database_name] ||= Sequel.connect(
        adapter: "mysql2",
        user: ENV["MARIADB_HT_RO_USERNAME"],
        password: ENV["MARIADB_HT_RO_PASSWORD"],
        host: ENV["MARIADB_HT_RO_HOST"],
        database: ENV["MARIADB_HT_RO_DATABASE"],
        encoding: "utf8mb4"
      )
    end
  end
end
