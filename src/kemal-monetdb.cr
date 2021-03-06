require "crystal-monetdb-libmapi"
require "crystal-monetdb-libmapi/monetdb_data"
require "pool/connection"
require "http"

macro connect
  env.monetdb.connect
end

macro release
  env.monetdb.release
end

def monetdb_connect(options) #, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::MonetDB.new(options) #, capacity, timeout)
end

class HTTP::Server::Context
  property! monetdb : MonetDB::Client | Nil
end

class Kemal::MonetDB < HTTP::Handler
  @monetdb : MonetDB::Client
  getter monetdb

  def initialize(options={} of String => String) #, capacity = 25, timeout = 0.1)
    @monetdb = MonetDB::Client.new
    @monetdb.host = options["host"]
    @monetdb.username = options["user"]
    @monetdb.password = options["password"]
    @monetdb.port = options["port"].to_i
    @monetdb.db = options["db"]
    @monetdb.connect
  end

  def call(context)
    context.monetdb = @monetdb
    call_next(context)
  end
end
