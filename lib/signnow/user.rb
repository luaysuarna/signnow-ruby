module Signnow
  class User < Base

    attr_accessor :id, :email, :first_name, :last_name, :attributes, :active,
      :type, :pro, :created, :emails, :identity, :subscriptions, :credits,
      :has_atticus_access, :is_logged_in, :teams

  end
end
