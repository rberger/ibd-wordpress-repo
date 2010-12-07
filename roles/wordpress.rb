name "wordpress"
description "IBD Blog using wordpress"
recipes "chef::client_service", "users::sysadmins", "sudo", "postfix", "wordpress", "vsftpd"

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
     "version" => "3.0.1",
     "checksum" => "fd76fb7683c32c4f2d65f5b2cd015cb62d19f1017e3b020f34a98d1b480e1818",
     "blog_updater" => "blog"
   },
   "vsftpd" => {"chroot_users" => %w(blog)}
)