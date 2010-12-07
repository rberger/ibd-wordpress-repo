# If you want this recipe install a password for the blog user, you can generate it with the following command on a Linux system that has makepasswd installed:
# hash_password=`echo "theplaintextpassword" | makepasswd --clearfrom=- --crypt-md5 |awk '{ print $2 }'`
# Or you can just add the password manually as superuser logged into the target system after this recipe is run
#

package "makepasswd"

if node[:wordpress][:blog_updater_hash].nil?
  ruby_block "create_blog_updater_pw" do
    Chef::Log.info("Doing makepasswd for blog_updater")
    node[:wordpress][:blog_updater_hash] = `echo #{node[:wordpress][:blog_updater][:password]} | /usr/bin/makepasswd --clearfrom=- --crypt-md5 |awk '{ print $2 }'`
  end
end

# Create the blog_updater user with their home directory being the wordpress directory and the group as the same group as the Apache runtime group
user "#{node[:wordpress][:blog_updater]}" do
  home "#{node[:wordpress][:dir]}"
  gid "#{node[:apache][:user]}"
  shell "/bin/false"
  supports :manage_home => true
  unless node[:wordpress][:blog_updater_hash].nil? || node[:wordpress][:blog_updater_hash].empty?
    password "#{node[:wordpress][:blog_updater_hash]}"
  end
end

