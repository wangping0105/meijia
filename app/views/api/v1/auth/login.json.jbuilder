json.code 0
json.data do
  json.user SimpleUserSerializer.new(@user)
  json.user_token @user.authentication_token
end