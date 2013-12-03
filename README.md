# [WIP] work in progress!!!

SignNow [![Build Status](https://secure.travis-ci.org/andresbravog/signnow-ruby.png)](https://travis-ci.org/andresbravog/signnow-ruby)
======

This is a Ruby wrapper for SignNow's API.

Documentation
=====

We use RubyDoc for documentation.

The documentation of the current release can be found here:
http://rubydoc.info/gems/paymill/frames/index

Usage
======

First, you've to install the gem

    gem install signnow

and require it

    require "signnow"

and set up your api_key

    Signnow.api_key = "_your_application_api_key_"


Users
=====

*[SignNow users API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-/user)*

Creating a user:

    Paymill::User.create(
      email: 'yournewuser@email.com', # required
      password: 'new_password', # required
      first_name: 'john', # optional
      last_name: 'doe', # optional
    )

Creating a new debit card payment:

    Paymill::Payment.create(type: "debit", code: "12345678", account: "1234512345", holder: "Max Mustermann")

Or finding an existing payment:

    Paymill::Payment.find("pay_3af44644dd6d25c820a8")

Deleting a payment:

    Paymill::Payment.delete("pay_3af44644dd6d25c820a8")



Documentation
=====

*[SignNow developers page](https://developers.signnow.com)*

*[SignNow API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints)*


Requirements
=====

This gem requires Ruby 1.9 and faces version 2 of Paymill's API.

Bugs
======

Please report bugs at http://github.com/andresbravog/signnow-ruby/issues.

Note on Patches/Pull Requests
======

* Fork the project from http://github.com/andresbravog/signnow-ruby.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
======

Copyright (c) 2012-2013 andresbravog Internet Service GmbH, Andres Bravo. See LICENSE for details.
