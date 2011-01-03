default[:wordpress][:blog_updater][:username] = "blog"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:wordpress][:blog_updater][:password] = secure_password
# hash set by recipe or manually using makepasswd
default[:wordpress][:blog_updater][:hash] = nil

# For creating the swap partition. Swap_size is in GB
default[:wordpress][:gb_swap_size] = 2
default[:wordpress][:swap_file] = "/swap_file"
