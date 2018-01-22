if Rails.env.production?

    CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'  
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region => ENV['AWS_REGION']
    }
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET']
    config.asset_host = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET']}"
  end

end


