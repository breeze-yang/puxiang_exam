json.partial! 'api/common/meta'
json.partial! 'api/common/api_result', api_result: api_result

json.data do
  json.access_token app_access_token.access_token
  json.cache! [:v1, user], expires_in: 1.weeks do
    json.user do
      json.partial! 'api/v1/users/user_base', user: user
    end
  end
end