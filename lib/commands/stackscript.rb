desc "List your stackscripts"
command :stackscript do |arg|
  ls = Linode::Stackscript.new(:api_key => helper.api_key)
  ls.list.each do |stackscript|
    puts "#{stackscript.stackscriptid}"
    puts "#{stackscript.script}"
  end
end