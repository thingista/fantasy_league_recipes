app, deploy = node[:deploy].first
if deploy == nil or deploy[:database] == nil
  default[:s3_backup] = nil
else
  default[:s3_backup] = {}
  default[:s3_backup][:email] = "camillieri.pj@mac.com"
  default[:s3_backup][:s3_bucket_uri] = "s3://fantasy-league-mysql-backups/"
  default[:s3_backup][:database] = deploy[:database][:database]
  default[:s3_backup][:database_user] = deploy[:database][:username]
  default[:s3_backup][:database_password] = deploy[:database][:password]
end