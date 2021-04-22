json.topics @topics.each do |topic|
  json.topic do
    json.topics @topics, partial: 'api/v1/topics/info', as: :topic
  end
end
