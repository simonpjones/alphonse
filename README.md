# Alphonse

Deployment gem

## Installation


## Usage

TODO: Write usage instructions here


## Note

Chances are you will experience issues with PATH variables and rubygems etc. So here's a quick solution:

Log in to your deployment server, as a root user, add the following line to /etc/ssh/sshd_config:

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
