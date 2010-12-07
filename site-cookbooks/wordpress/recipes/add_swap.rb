bash "add_swap" do
  user "root"
  code <<-EOH
  sudo dd if=/dev/zero of=#{node[:wordpress][:swap_file]} bs=1G count=#{node[:wordpress][:swap_size]}
  sudo chown root:root #{node[:wordpress][:swap_file]}
  sudo chmod 600 #{node[:wordpress][:swap_file]}
  sudo mkswap #{node[:wordpress][:swap_file]}
  sudo swapon #{node[:wordpress][:swap_file]}
  EOH
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