module ApplicationHelper
	def logged?
		if session[:user]
			true
		else
			false
		end
	end
end