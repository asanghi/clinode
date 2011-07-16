command :avail do |args|
  helper.linode_config
  ls = helper.linode
  return if !ls

  params = {}

  case args
  when "plans"
    if options.has_key?(:planid)
      params[:planid] = options[:planid]
    end
    puts ls.avail.linodeplans(params)
  when "datacenters"
    puts ls.avail.datacenters
  when "distributions"
    if options.has_key?(:distributionid)
      params[:distributionid] = options[:distributionid]
    end
    puts ls.avail.distributions(params)
  when "kernels"
    if options.has_key?(:kernelid)
      params[:kernelid] = options[:kernelid]
    end
    if options.has_key?(:isxen)
      params[:isxen] = options[:isxen]
    end
    puts ls.avail.kernels(params)
  when "stackscripts"
    if options.has_key?(:distributionid)
      params[:distributionid] = options[:distributionid]
    end
    if options.has_key?(:distributionvendor)
      params[:distributionvendor] = options[:distributionvendor]
    end
    if options.has_key?(:keywords)
      params[:keywords] = options[:keywords]
    end
    puts ls.avail.stackscripts(params)
  end

end
