# [WIP] work in progress!!!

SignNow [![Build Status](https://secure.travis-ci.org/andresbravog/signnow-ruby.png)](https://travis-ci.org/andresbravog/signnow-ruby) [![Code Climate](https://codeclimate.com/github/andresbravog/signnow-ruby.png)](https://codeclimate.com/github/andresbravog/signnow-ruby) [![Coverage Status](https://coveralls.io/repos/andresbravog/signnow-ruby/badge.png)](https://coveralls.io/r/andresbravog/signnow-ruby)
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

    Signnow.configure do |config|
      config[:app_id] = "_your_application_app_id_",
      config[:app_secret] = "_your_application_app_secret_"
    end

set the extra ```:use_test_env?``` config option to true if you want to use the [signnow test environment](https://eval.signnow.com)

    Signnow.configure do |config|
      config[:use_test_env?] = true
    end

Oauth
=====

*[SignNow oauth2 API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-POST/oauth2)*

Redirecting the user to the authorize url, You need to provide a redirect url where you will get a code param.

    # Redirect the user to the authorize url
    redirect_to Signnow::Authentications::Oauth.authorize_url(redirect_uri: your_redirect_url)

Process the code param in order to get user oauth credentials.

    oauth_credentials = Signnow::Authentications::Oauth.authenticate(code: code)

    =>
    {
      access_token: '_user_access_token_',
      refresh_token: '_user_refresh_token',
      token_type: 'bearer',
      scope: '*',
      last_login: 2013929273,
      expires_in: 2013929273
    }

Store the access token credentials in order to use the Signnow API

    Signnow::User.show(access_token: oauth_credentials.access_token)


Users
=====

*[SignNow users API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-/user)*

Creating a user:

    user = Singnow::User.create(
      email: 'yournewuser@email.com', # required
      password: 'new_password', # required
      first_name: 'john', # optional
      last_name: 'doe', # optional
    )

Store the acess_token

    token = user.access_token

Generate a client with the access token

    client = Signnow::Client.new(token)

Showing a user:

    client.perform! |token|
      Singnow::User.show(access_token: token)
    end


Documents
=====

*[SignNow documents API documentation](https://signnow.atlassian.net/wiki/display/SAPI/REST+Endpoints#RESTEndpoints-/document)*

List user documents:

    client.perform! |token|
      Singnow::Document.all(access_token: token)
    end

Show a docuemnt:

    client.perform! |token|
      Singnow::Document.show(id: 'document_id', access_token: token)
    end

Download a docuemnt:

    client.perform! |token|
      Singnow::Document.download(id: 'document_id', access_token: token)
    end


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
