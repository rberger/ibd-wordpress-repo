name "wordpress"
description "Blog using wordpress"
recipes "chef::client_service", "users::sysadmins", "sudo", "postfix", "mysql::server", "wordpress", "wordpress::blog_user", "wordpress::add_swap", "vsftpd"

override_attributes(
  "postfix" => {"myhostname" => "test.ibd.com", "mydomain" => "ibd.com"},
  "authorization" => {
    "sudo" => {
      "groups" => [],
      "users" => ["rberger", "ubuntu"]
    }
  },
  "wordpress" => {
     "server_aliases" => %w(test.ibd.com wordpress-test.ibd.com),
     "version" => "3.0.4",
     "checksum" => "c68588ca831b76ac8342d783b7e3128c9f4f75aad39c43a7f2b33351634b74de",
     "blog_updater" => {
       "username" => "blog",
       "password" => "big-secret"
     }
   },
   "vsftpd" => {"chroot_users" => %w(blog)}
)