# This shouldnt be required if we get the patch into rick's linode api gem
helper :stackscript_linode do
  Linode::Stackscript.new(:api_key => Clinode.options[:api_token])
end

helper :print_stackscript do |script|
  if Clinode.options[:output]
    puts script.script
  else
    puts script.to_yaml
  end
end

helper :stackscript_list do |ls|
  Clinode.debug "listing"
  ls.list.each do |stackscript|
    print_stackscript(stackscript)
  end
end

helper :stackscript_meta_update do |ls,stackscript_id,opts|
  params = opts
  params[:stackscriptid] = stackscript_id
  ls.update(params)
end

helper :stackscript_update do |ls,stackscript_id,filename|
  if File.exists?(filename)
    script = File.read(filename)
    ls.update(:stackscriptid => stackscript_id,:script => script)
    puts "Stack Script #{stackscript_id} uploaded."
  end
end

helper :stackscript_upload do |ls|
  Clinode.debug "uploading"
  Dir["#{Clinode.options[:dir]}/*_stack.sh"].each do |filename|
    if (filename =~ /(\d+)\_stack\.sh$/)
      stackscript_update(ls,$1,filename)
    end
  end
end

helper :stackscript_download do |ls|
  ls.list.each do |stackscript|
    filename = "#{Clinode.options[:dir]}/#{stackscript.stackscriptid}_stack.sh"
    File.open(filename,"w+"){|f|f.write(stackscript.script)}
    Clinode.debug "Writing Script #{stackscript.stackscriptid} #{stackscript.label} into #{filename}"
  end
end

helper :stackscript_process do |ls,stackscript_id|
  Clinode.debug "Fetching StackScript #{stackscript_id}"
  stackscript = ls.list(:stackscript => stackscript_id)
  print_stackscript(stackscript[0])
end

desc "List your stackscripts"
usage "--dir=<directory> stackscript directory to upload from/download to"
flags :output => "Output the content of the stackscript only"
flags :update => "Update the content of the stackscript"
command :stackscript do |arg|
  helper.linode_config
  ls = helper.stackscript_linode
  return if !ls

  options[:dir] ||= "."

  case arg
  when "list"
    helper.stackscript_list(ls)
  when "upload"
    helper.stackscript_upload(ls)
  when "download"
    helper.stackscript_download(ls)
  when /^\d+$/
    if options[:update]
      filename = "#{options[:dir]}/#{arg}_stack.sh"
      helper.stackscript_update(ls,arg,filename)
    else
      helper.stackscript_process(ls,arg)
    end
  end

end