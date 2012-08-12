#encoding: utf-8
require File.expand_path("../env",__FILE__)

#我经常在开发过程中需要链接数据库(在shell环境中)所有我想把这个功能给抽出来使用
class Mysql 
	attr_reader :db, 			#数据库名
							:ip, 			#要链接数据库的ip
							:user, 		#链接数据库的用户名
							:password #链接数据库用户的密码
	#初始化
	def initialize *args
	 @db = args[0] 
	 @ip = args[1] || "127.0.0.1"
	 @user = args[2] || "root"
	 @password =  args[3] || ""
	end

	#链接数据库
	def connect
		 log_ok "ip=>#{@ip} 数据库=> #{@db} "
		 ActiveRecord::Base.establish_connection({
      :adapter  => "mysql2",
      :database => @db,
      :encoding => "utf8",
      :port     => 3306,
      :host     => @ip,
      :username => @user,
      :password => @password
    	})
		 # log_ok "当前链接的数据库是:#{@db}"
	end

	#输出当前链接数据库的信息
	def current_db
		log_ok "当前链接的数据库是:#{@db}"
	end

	#改变数据库
	def change_db db
		@db = db
		connect
	end

end
