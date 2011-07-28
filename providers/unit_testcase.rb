action :create do
  new_resource.name("test_#{new_resource.name.gsub("-","_").to_sym}") unless new_resource.name =~ /^test_/
  Chef::Log.debug "minitest_unit_testcase[#{new_resource.name}] fired action :create"
  new_resource.updated_by_last_action(true)
end


