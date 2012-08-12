#encoding: utf-8
require "colored"
require "active_record"

module Helper

	#用于输出一般的日志信息
	def	log_ok info
		puts "==> #{info}".yellow
	end

	#用于输出错误的日志信息
	def log_error info
		puts "[error] #{info}".red
	end

	def help
		log_ok = <<-EOF
			以下是描述信息:
			方法 'cdb' 用来链接数据库的参数依次是(数据库名,ip,数据库用户名,数据库对应用户名的密码)
			方法 'dm' 用来定义一个类,这个类对应到数据库中的某一表参数分别为(model名,表名,主键)
			首先要使用方法"cdb"链接到数据库,然后再操作其中的类
		EOF
	end

end
