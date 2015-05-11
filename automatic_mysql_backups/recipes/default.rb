if node[:opsworks][:instance][:hostname] == 'rails-app1' and node[:s3_backup] != nil

  template "/srv/www/backup_to_s3.sh" do
  	mode "0744"
  	source 'backup_to_s3.sh.erb'
  	variables(node[:s3_backup])
  end

  gem_package "whenever" do
    action :install
  end

  cookbook_file "/srv/www/backup_to_s3_schedule.rb" do
    source "backup_to_s3_schedule.rb"
    mode "0644"
  end
  directory "/srv/www/backup_to_s3_schedule_log" do
  	action :create
  end
  execute "execute_whenever" do
    #cwd "/srv/www/backup_to_s3_schedule_log"
    command "whenever --set --update-crontab automatic_mysql_backups --load-file /srv/www/backup_to_s3_schedule.rb"
    action :run
  end
end


