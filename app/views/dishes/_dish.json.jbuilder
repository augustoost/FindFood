json.extract! dish, :id, :description, :price, :time, :created_at, :updated_at
json.url dish_url(dish, format: :json)
