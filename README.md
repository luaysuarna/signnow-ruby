# [WIP] work in progress!!!

SignNow [![Build Status](https://secure.travis-ci.org/andresbravog/signnow-ruby.png)](https://travis-ci.org/andresbravog/signnow-ruby)
======

This is a Ruby wrapper for SignNow's API.

Documentation
=====

We use RubyDoc for documentation.

Usage
======

First, you've to install the gem

    gem install signnow

and require it

    require "signnow"

and set up your api_key

    Signnow.api_key = "_your_application_api_key_"

all the operations made over a user needs a oauth_token

    Signnow.oauth_token = "_your_user_oauth_token_"


Oauth
=====

*[SignNow oauth2 API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-POST/oauth2)*

Creating a oauth token:

    oauth = Signnow::Authentications::Oauth.authenticate(
      email: 'yournewuser@email.com', # required
      password: 'user_password', # required
    )
    Signnow.oauth_token = oauth.access_token


Users
=====

*[SignNow users API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-/user)*

Creating a user:

    Singnow::User.create(
      email: 'yournewuser@email.com', # required
      password: 'new_password', # required
      first_name: 'john', # optional
      last_name: 'doe', # optional
    )

Showing a user:

    Singnow::Payment.show


Documents
=====

*[SignNow documents API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-/document)*

List user documents:

    Singnow::Document.all

Show a docuemnt:

    Singnow::Document.show(id: 'document_id')

Download a docuemnt:

    Singnow::Document.download(id: 'document_id')


Documentation
=====

*[SignNow developers page](https://developers.signnow.com)*

*[SignNow API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints)*


Requirements
=====

This gem requires at least Ruby 1.9 and faces version 1 of SignNow's API.

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
