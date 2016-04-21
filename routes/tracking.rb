get '/favicon.ico' do
  return_one_by_one_pixel
end

get '/apple-*.png' do
  return_one_by_one_pixel
end

get '*' do
  RedisQueue.new($redis_pool).
    push("%s %i %s %s %s" % [request.ip, Time.now.to_i,
                             request.path, request.query_string,
                             request.user_agent])
  return_one_by_one_pixel
end