# Get the password cryptographic hash for node[:wordpress][:blog_updater][:password
package "makepasswd"
package "libshadow-ruby1.8"
if node[:wordpress][:blog_updater][:hash].nil? || node[:wordpress][:blog_updater][:hash].empty?
  cmd = "echo #{node[:wordpress][:blog_updater][:password]} | /usr/bin/makepasswd --clearfrom=- --crypt-md5 |awk '{ print $2 }'"
  ruby_block "create_blog_updater_pw" do
    block do
      node.set[:wordpress][:blog_updater][:hash] = `#{cmd}`.chomp
    end
    action :create
  end
end

# Create the blog_updater user with their home directory being the wordpress directory and the group as the same group as the Apache runtime group
user "#{node[:wordpress][:blog_updater][:username]}" do
  home "#{node[:wordpress][:dir]}"
  gid "#{node[:apache][:user]}"
  shell "/bin/bash"
  supports :manage_home => true
  unless node[:wordpress][:blog_updater][:hash].nil? || node[:wordpress][:blog_updater][:hash].empty?
    password "#{node[:wordpress][:blog_updater][:hash]}"
  end
end

# Change the ownership of the wordpress directory so that the blog user can update
execute "chown wordpress home for blog user" do
  cwd "#{node[:wordpress][:dir]}"
  user "root"
  command "chown -R #{node[:wordpress][:blog_updater][:username]}:#{node[:apache][:user]} #{node[:wordpress][:dir]}"
  not_if { node[:wordpress][:dir].nil? || node[:wordpress][:dir].empty? || (not File.exists?(node[:wordpress][:dir])) }
end
  