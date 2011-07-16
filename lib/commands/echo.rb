command :echo do
  helper.linode_config
  ls = helper.stackscript_linode
  return if !ls

  puts ls.test.echo(options)
end