class InsClient
	def initlialize(access_token)
        Instagram.client(access_token: access_token)
	end
end