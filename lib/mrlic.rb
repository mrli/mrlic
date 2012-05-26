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
	putsy "要操作的类是:#{class_name}"
	
	table = args[1] || "#{class_name}s"
	putsy "要操作的数据库表是:#{table}"
	
	primary_key = args[2]  || "id"
	putsy "表:#{table} 的主键是:#{primary_key}"

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
	putsy <<-EOF
		以下是描述信息:
		方法 'cdb' 用来链接数据库的参数依次是(数据库名,ip,数据库用户名,数据库对应用户名的密码)
		方法 'dm' 用来定义一个类,这个类对应到数据库中的某一表参数分别为(model名,表名,主键)
		首先要使用方法"cdb"链接到数据库,然后再操作其中的类
	EOF
	mysql = Mysql.new *args;
	mysql.connect
end

# cdb "active_admin_study"
# dm "AdminUser","admin_users"
# puts AdminUser.first.attributes	











