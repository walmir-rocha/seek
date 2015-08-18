Devise.setup do |config|
  config.secret_key = 'c94299f4119973fc0e2fe7e0aa0fb437c3c28d18203b1cbba38d50cb22124e79bfc182e5c2a636b1e5d1e283e919cdbec4a46ecfde2ddfeb90572a1e218f0214'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :ldap, :host => 'edir.manchester.ac.uk',
      :base => 'ou=people,o=University of Manchester,c=GB',
      :uid => 'uid',
      :port => 389,
      :method => :plain,
      :allow_anonymous => true

end
