Chronline
=========

Setting Up
----------

First you need [git](http://git-scm.com/book/en/Getting-Started-Installing-Git) in order to clone this repository. Next, you will need Ruby 1.9.3. You should install ruby and rubygems with [rvm](https://rvm.io/rvm/install/). You should also get Node.js and npm. I recommend using [nvm](https://github.com/creationix/nvm) to install them. Once you have those utilities, clone this repository and change into the directory. Then execute the following in your shell:

```bash
# Globally install Node.js utility binaries
$ npm install -g bower phantomjs

# Install required gems
$ bundle install --without production

# Install client side vendor assets with bower
$ rake bower:install

# Rails database initialization
$ rake db:migrate
$ rake db:test:prepare
```

### Configuration files

You will be able to run tests at this point, but will not be able to run the server in the development environment until you supply the `config/settings/development.local.yml` file. This is not version controlled since it contains sensitive information. You can populate it using the `config/settings/test.yml` file as a template.

Once the development environment is configured it, you may wish to populate your development database with random data using the command `$ rake db:populate`.

Running tests
-------------

You can run acceptance tests with the following command:

```bash
$ cucumber features
```

You can run spec tests with the following command:

```bash
$ rspec spec
```
