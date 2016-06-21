require "crystal-monetdb-libmapi"
#require "pool/connection"
require "http"

macro conn
  env.monetdb.connect
end

macro release
  env.monetdb.release
end

def monetdb_connect(options) #, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::MonetDB.new(options, capacity, timeout)
end

class HTTP::Server::Context
  @monetdb : MonetDBMAPI::Mapi # | Nil
  property! monetdb
end

class Kemal::MonetDB < HTTP::Handler
  @monetdb : MonetDBMAPI::Mapi
  getter monetdb

  def initialize(options={} of String => String) #, capacity = 25, timeout = 0.1)
    #@monetdb = ConnectionPool.new(capacity: capacity, timeout: timeout) do
    #  ::MonetDB::Client.connect(options["host"], options["user"], options["password"], options["db"], 3306_u16, nil)
    #end
    @monetdb = MonetDB::Client.new
    @monetdb.host = options["host"]
    @monetdb.username = options["user"]
    @monetdb.password = options["password"]
    @monetdb.db = options["db"]
    @monetdb.connect
  end

  def call(context)
    context.mysql = @monetdb
    call_next(context)
  end
end
