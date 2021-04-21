json.topics @topics.each do |topic|
  json.topic do
    json.partial! 'api/v1/topics/info', topic: topic
  end
end
