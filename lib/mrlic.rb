#encoding: utf-8
#! /usr/bin/ruby 
require File.expand_path("../env",__FILE__)
require File.expand_path("../connect_db",__FILE__)

include Helper

# 定义一个model类,对应到数据库中的表
def defind_model *args
	class_name = args[0]
	log_ok "要操作的类是:#{class_name}"
	
	table = args[1] || "#{class_name}s"
	log_ok "要操作的数据库表是:#{table}"
	
	primary_key = args[2]  || "id"
	log_ok "表:#{table} 的主键是:#{primary_key}"

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
	puts "0k"
end


# cdb "shark3dev_world"
# dm "Item","map_dbc","MapID"
# puts Item.count




# cdb "active_admin_study"
# dm "AdminUser","admin_users"
# puts AdminUser.first.attributes	











