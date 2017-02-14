# Protégé Authentication|Authorization Mechanism using OpenID Connect

My attempt to implement OpenID Connect on a startup that I started with my friends.
An OpenID Connect Provider Project using the `openid_connect` gem.

## Resources

* View original source on GitHub: https://github.com/nov/openid_connect_sample
* Report Issues on GitHub: https://github.com/nov/openid_connect_sample/issues

## How to Run This Project on Your Machine

### Localhost

To run this in development mode on your local machine:

* Download (or fork or clone) this repo
* Make sure you have downloaded PostgreSQL on your machine, if you haven't resort to Google and search how to install postgreSQL on your machine
* `bundle install` (see "Note" section below if you get "pg"-gem-related problems)
* `bundle exec rake db:create db:migrate db:seed` (you have SQLite installed, right?)
* Modify `config/connect/id_token/issuer.yml` -- change `issuer` to http://localhost:3000
* `bundle exec rails server -p 3000`
* Point your browser at http://localhost:3000

## Notes

* The Gemfile includes gem 'pg' (for PostgreSQL), but you can remove it.
  Nov uses PostgreSQL for his Heroku deployment, but the default DB configs are all SQLite.
* The Facebook link won't work unless you register your app with them.
* Email obed.tandadjaja@gmail.com for the project's Facebook and Google clientID and clientSecret

## Centos OpenSSL Complications

Centos' default OpenSSL package does not include some Elliptic Curve algorithms for patent reasons.
Unfortunately, the gem dependency `json-jwt` calls on one of those excluded algorithms.

If you see `uninitialized constant OpenSSL::PKey::EC` when you try to run the server,
this is your problem. You need to rebuild OpenSSL to include those missing algorithms.

This problem is beyond the scope of this README, but
[this question on StackOverflow](http://stackoverflow.com/questions/32790297/uninitialized-constant-opensslpkeyec-from-ruby-on-centos/32790298#32790298)
may be of help.


## Copyright

Copyright (c) 2015 Protégé LLC. See http://protege.xyz for details.

Copyright (c) 2011 nov matake. See LICENSE for details.
