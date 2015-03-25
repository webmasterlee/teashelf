json.array!(@atts) do |att|
  json.extract! att, :id, :name, :user_id
  json.url att_url(att, format: :json)
end
