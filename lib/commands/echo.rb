command :echo do
  ls = helper.get_linode

  puts ls.test.echo(options)
end