json.array!(@tea_types) do |tea_type|
  json.extract! tea_type, :id, :name, :user_id
  json.url tea_type_url(tea_type, format: :json)
end
