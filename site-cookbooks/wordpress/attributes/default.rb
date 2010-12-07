default[:wordpress][:version] = "3.0.1"
default[:wordpress][:checksum] = "fd76fb7683c32c4f2d65f5b2cd015cb62d19f1017e3b020f34a98d1b480e1818"
default[:wordpress][:blog_updater][:username] = "blog"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:wordpress][:blog_updater][:password] = secure_password
# hash set by recipe or manually using makepasswd
default[:wordpress][:blog_updater][:hash] = nil
default[:wordpress][:swap_size] = 2
default[:wordpress][:swap_file] = "/swap_file"