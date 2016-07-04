json.array!(@rats) do |rat|
  json.extract! rat, :id, :users_id, :longbreak, :latebreak, :offtask, :other
  json.url rat_url(rat, format: :json)
end
