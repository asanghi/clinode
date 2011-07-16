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
  VALID_KEYS = [:label,:ispublic,:rev_note,:description]
  params = opts.reject{|key,value| !VALID_KEYS.include?(key)}
  params[:stackscriptid] = stackscript_id
  ls.update(params)
end

helper :stackscript_create do |ls,opts|
  VALID_KEYS = [:label,:ispublic,:rev_note,:description]
  params = opts.reject{|key,value| !VALID_KEYS.include?(key)}
  params[:script] = File.read(Clinode.options[:file])
  ls.create(params)
end

helper :stackscript_delete do |ls,stackscript_id|
  ls.delete(:stackscriptid => stackscript_id)
  puts "Stack Script #{stackscript_id} deleted."
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
usage "commands allowed: list, upload, download, create"
usage "--dir=<directory> stackscript directory to upload from/download to"
usage "--label=<new label>"
usage "--ispublic=true/false"
usage "--description=<stackscript update>"
usage "--rev_note=<revision note>"
flags :output => "Output the content of the stackscript only"
flags :update => "Update the content of the stackscript"
flags :meta_update => "Update the meta data of the stackscript"
flags :delete => "Delete the given stack script"
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
  when "create"
    helper.stackscript_create(ls,options)
  when /^\d+$/
    if options[:update]
      filename = "#{options[:dir]}/#{arg}_stack.sh"
      helper.stackscript_update(ls,arg,filename)
    elsif options[:meta_update]
      helper.stackscript_meta_update(ls,arg,options)
    elsif options[:delete]
      helper.stackscript_delete(ls,arg)
    else
      helper.stackscript_process(ls,arg)
    end
  end

end