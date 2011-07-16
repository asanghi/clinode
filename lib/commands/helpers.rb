helper :linode_config do
  config_file = "#{ENV['HOME']}/.linode.yml"
  if File.exists?(config_file)
    config = YAML::load_file(config_file)
    config.keys.each do |k|
      Clinode.options[k] = config[k]
    end
  end
end

helper :linode do
  linode_config
  if Clinode.options[:api_token]
    Linode.new(:api_key => Clinode.options[:api_token])
  end
end
