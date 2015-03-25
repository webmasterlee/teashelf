json.array!(@teas) do |tea|
  json.extract! tea, :id, :name, :stock, :notes, :url, :user_id, :tea_type_id
  json.url tea_url(tea, format: :json)
end
