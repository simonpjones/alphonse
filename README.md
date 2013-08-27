# Alphonse

Deploy like the fonz with this simple deployment gem.

## Installation

1. Either `gem install alphonse` or add it to your Gemfile `gem "alphonse", "~> 0.0.5"`.
2. Navigate to the directory in which you wish to use alphonse.
3. Run `alphonse init` - this will generate the default Fonzfile.
4. Edit the Fonzfile to suit your app and deployment operations required.

## Usage

Once you have finished optmising the Fonzfile with the specific operations configurations, run the operations using `alphonse [OPERATION] [OPTIONS]`:

`alphonse setup`
`alphonse deploy -e staging` (the environment will be used when running rake tasks)
`alphonse update --verbose` (verbose will return the output of each command irrelevant of success or failure)

### Task

A Task is a set of simple commands that are to be run in sequence. For example, the preset :clone_repository action consists of the following commands used to clone a git repository:
  
  `"git checkout master -q", "git pull origin master -q", "git gc --aggressive"`

### Operation

An Operation is in turn a collection of Tasks which are run in sequence. For example, the present :deploy operation consists of the following Tasks which could be considered necessary for a Rails app deployment

  ```ruby
  :install_gems, :setup_database, :restart_app
  ```

### Example Fonzfile

  ```ruby
  # Settings
  user 'remote_user'
  app_name 'application_name'
  hosts 'stage.example.com'
  path "/fullpath/to/folder"
  git_repo 'git@gitaddress:application_name.git'
  branch 'master'
  ruby_bin_path '/path/to/ruby/'
  start_command 'start_app command' 
  restart_command 'restart_app command' # E.g. 'touch tmp/restart.txt'

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
  ```

## Note

Chances are you will experience issues with PATH variables and rubygems etc. So here's a quick solution:

Log in to your server, as a root user, add the following line to /etc/ssh/sshd_config:

    PermitUserEnvironment yes

Don’t forget to restart ssh:

    /etc/init.d/ssh restart

Now, log in as the deployment user, and create ‘~/.ssh/environment’ with the following content:

    PATH=/usr/local/rvm/gems/ruby-2.0.0-p247/bin:/bin:/usr/local/rvm/rubies/ruby-2.0.0-p247/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    GEM_HOME=/usr/local/rvm/gems/ruby-2.0.0-p247

*The above paths are for your reference only, obviously you need to work them out for your server environment. The only thing you need to make sure is that the GEM_HOME's path matches one from the PATH.*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

![May the Fonz be with you](http://lovablelabelsblog.com/wp-content/uploads/2010/03/fonz1.jpg)
