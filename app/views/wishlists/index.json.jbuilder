json.array!(@wishlists) do |wishlist|
  json.extract! wishlist, :id, :name, :notes, :url, :user_id
  json.url wishlist_url(wishlist, format: :json)
end
