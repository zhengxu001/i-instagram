json.extract! user, :id, :user_id, :user_name, :profile_picture, :full_name, :access_token, :created_at, :updated_at
json.url user_url(user, format: :json)
