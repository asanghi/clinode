flags :pending => "Only Pending"
command :job do |args|
  ls = helper.get_linode

  params = {:linodeid => args, :pendingonly => options[:pending]}

  if options.has_key?(:jobid)
    params[:jobid] = options[:jobid]
  end

  puts ls.job.list(params)

end