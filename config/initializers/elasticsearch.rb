if Rails.env.production?
ENV["ELASTICSEARCH_URL"] = "http://paas:f81e17da2a276fea5a4e2c082641adff@dori-us-east-1.searchly.com"
end