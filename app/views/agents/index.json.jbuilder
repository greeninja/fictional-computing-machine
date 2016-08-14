json.array!(@users) do |user|
  json.extract! user, :id, :name, :team
  json.url agent_url(user, format: :json)
end
