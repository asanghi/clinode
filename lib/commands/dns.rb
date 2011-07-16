command :dns do |args|
  helper.linode_config
  ls = helper.stackscript_linode
  return if !ls

  params = {}

  case args
  when "list"
    if options.has_key?(:domainid)
      params[:domainid] = options[:domainid]
    end
    puts ls.domain.list(params)
  end

end

command :dns_resource do |args|
  helper.linode_config
  ls = helper.stackscript_linode
  return if !ls

  return if !options.has_key?(:domainid)

  params = {:domainid => options[:domainid]}

  case args
  when "list"
    if options.has_key?(:resourceid)
      params[:resourceid] = options[:resourceid]
    end
    puts ls.domain.resource.list(params)
  end

end