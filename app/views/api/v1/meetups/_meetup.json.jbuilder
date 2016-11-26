cache_key = [:v1, meetup, meetup.user, meetup.replies_count]
json.cache! cache_key, expires_in: 1.weeks do
  json.id            meetup.id
  json.title         meetup.title
  json.body          meetup.body
  json.replies_count meetup.replies_count
  json.created_at    meetup.created_at
  json.updated_at    meetup.updated_at

  json.sponsor do
    json.id       meetup.user.id
    json.username meetup.user.username
  end
end

