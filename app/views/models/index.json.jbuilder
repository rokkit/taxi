json.array!(@models) do |model|
  json.extract! model, :account, :total, :user_id
  json.url model_url(model, format: :json)
end
