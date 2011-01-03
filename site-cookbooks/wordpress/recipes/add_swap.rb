mb_block_size = 100
count = (node[:wordpress][:gb_swap_size] * 1024) / mb_block_size
bash "add_swap" do
  user "root"
  code <<-EOH
  dd if=/dev/zero of=#{node[:wordpress][:swap_file]} bs=#{mb_block_size}M count=#{count}
  chown root:root #{node[:wordpress][:swap_file]}
  chmod 600 #{node[:wordpress][:swap_file]}
  mkswap #{node[:wordpress][:swap_file]}
  swapon #{node[:wordpress][:swap_file]}
  EOH
  not_if { File.exists?(node[:wordpress][:swap_file]) }
end

template "/etc/fstab" do
  source "fstab.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :swap_file => "#{node[:wordpress][:swap_file]}"
  )
end