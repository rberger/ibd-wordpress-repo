# Get the password cryptographic hash for node[:wordpress][:blog_updater][:password
package "makepasswd"
package "libshadow-ruby1.8"
Chef::Log.info("++++++++++ blog_user TOP node[:wordpress][:blog_updater][:hash]: #{node[:wordpress][:blog_updater][:hash].inspect} node[:wordpress][:blog_updater][:password]: #{node[:wordpress][:blog_updater][:password].inspect}")
if node[:wordpress][:blog_updater][:hash].nil? || node[:wordpress][:blog_updater][:hash].empty?
  cmd = "echo #{node[:wordpress][:blog_updater][:password]} | /usr/bin/makepasswd --clearfrom=- --crypt-md5 |awk '{ print $2 }'"
  Chef::Log.info("cmd: #{cmd}")
  ruby_block "create_blog_updater_pw" do
    result =  `#{cmd}`.chomp
    node.set[:wordpress][:blog_updater][:hash] = result
  end
end

# Create the blog_updater user with their home directory being the wordpress directory and the group as the same group as the Apache runtime group
user "#{node[:wordpress][:blog_updater][:username]}" do
  home "#{node[:wordpress][:dir]}"
  gid "#{node[:apache][:user]}"
  shell "/bin/false"
  supports :manage_home => true
  unless node[:wordpress][:blog_updater][:hash].nil? || node[:wordpress][:blog_updater][:hash].empty?
    password "#{node[:wordpress][:blog_updater][:hash]}"
  end
end

