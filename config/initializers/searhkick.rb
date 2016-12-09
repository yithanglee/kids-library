if Rails.env.development?
  Searchkick.client =
    Elasticsearch::Client.new(
      url: '127.0.0.1:9200',
      transport_options: {request: {timeout: 200}}
    )
end