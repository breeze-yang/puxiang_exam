json.partial! 'api/common/meta'
json.partial! 'api/common/api_result', api_result: api_result

json.data do
  json.items do
    json.array! meetups do |meetup|
      json.partial! 'meetup', meetup: meetup
    end
  end
end