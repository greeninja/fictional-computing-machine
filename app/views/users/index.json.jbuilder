json.array!(@users) do |user|
  json.extract! user, :id, :name, :team
  json.url user_url(user, format: :json)
end
