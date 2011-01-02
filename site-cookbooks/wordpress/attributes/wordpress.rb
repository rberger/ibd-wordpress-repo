default[:wordpress][:version] = "3.0.4"
default[:wordpress][:checksum] = "c68588ca831b76ac8342d783b7e3128c9f4f75aad39c43a7f2b33351634b74de"
default[:wordpress][:blog_updater][:username] = "blog"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:wordpress][:blog_updater][:password] = secure_password
# hash set by recipe or manually using makepasswd
default[:wordpress][:blog_updater][:hash] = nil
default[:wordpress][:swap_size] = 2
default[:wordpress][:swap_file] = "/swap_file"

# Not sure why, but had to duplicate this from the main wordpress atttributes
default[:wordpress][:db][:user] = "wordpressuser"
default[:wordpress][:db][:password] = secure_password
default[:wordpress][:keys][:auth] = secure_password
default[:wordpress][:keys][:secure_auth] = secure_password
default[:wordpress][:keys][:logged_in] = secure_password
default[:wordpress][:keys][:nonce] = secure_password
