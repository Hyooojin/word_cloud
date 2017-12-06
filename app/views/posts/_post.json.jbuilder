json.extract! post, :id, :title, :src_url, :tag1, :tag2, :tag3, :desc, :created_at, :updated_at
json.url post_url(post, format: :json)
