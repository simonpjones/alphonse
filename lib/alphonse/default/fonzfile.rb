# Settings
user 'remote_user'
app_name 'app_name'
hosts 'stage.example.com'
path "/fullpath/to/folder"
git_repo 'git@gitaddress:repository.git'
branch 'master'
ruby_bin_path '/path/to/ruby/'
restart_command 'touch tmp/restart.txt'

operation :setup, 'Setup server' do
  tasks :setup_directory
end

operation :deploy, 'Deploy repository' do
  tasks :clone_repository, :install_gems, :setup_database, :start_app
end

operation :update, 'Update the repository on the server' do
  tasks :update_repository, :install_gems, :update_database, :restart_app
end

operation :restart, 'Restart application' do
  tasks :restart_app
end


# Tasks
  # setup_directory
  # clone_repository
  # update_repository
  # install_gems
  # setup_database
  # update_database
  # start_app
  # restart_app