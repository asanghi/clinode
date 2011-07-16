command :nodebalancer do |args|
  helper.linode_config
  ls = helper.stackscript_linode
  return if !ls

  case args
  when "list"
    puts ls.nodebalancer.list()
  end
end
