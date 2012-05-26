#encoding: utf-8
require File.expand_path("../tools/puts_helper",__FILE__)
require "active_record"

#我经常在开发过程中需要链接数据库(在shell环境中)所有我想把这个功能给抽出来使用
class Mysql 
	attr_reader :db,:ip,:user,:password
	def initialize *args
	 @db = args[0] 
	 @ip = args[1] || "127.0.0.1"
	 @user = args[2] || "root"
	 @password =  args[3] || ""
	end

	def connect
		 putsy "准备链接ip:#{@ip} | 访问数据库:#{@db}"
		 ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :database => @db,
      :encoding => "utf8",
      :port     => 3306,
      :host     => @ip,
      :username => @user,
      :password => @password,
 		)
		putsy "ok! 当前数据库为:#{@db}"
	end

	def current_db
		putsy "是的,当前数据库为:#{@db}"
	end

end

# 定义一个model类,对应到数据库中的表
def defind_model *args
	class_name = args[0]
	table = args[1] || "#{class_name}s"
	primary_key = args[2]  || "id"
	eval <<-EOF
		class #{class_name} < ActiveRecord::Base
			self.table_name = \"#{table}\";
			self.primary_key = \"#{primary_key}\"
		end
	EOF
end
alias :dm :defind_model

# 操作入口 
def cdb(*args)
	mysql = Mysql.new *args;
	mysql.connect
end

# cdb "active_admin_study"
# dm "AdminUser","admin_users"
# puts AdminUser.first.attributes	











