command :nodebalancer do |args|
  ls = helper.get_linode

  case args
  when "list"
    puts ls.nodebalancer.list()
  end
end
