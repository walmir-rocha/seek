class OmniauthCallbacksController < Devise::OmniauthCallbacksController
 
    def ldap
        # We only find ourselves here if the authentication to LDAP was successful.
        ldap_return = request.env["omniauth.auth"]["extra"]["raw_info"]

        # entry = ldap_return
        # logger.debug "DN: #{entry.dn}"
        # entry.each do |attribute, values|
        #   logger.debug "   #{attribute}:"
        #   values.each do |value|
        #     logger.debug "      --->#{value}"
        #   end
        # end
        # logger.debug "Showing parameters"
        # params.each do |p|
        #   logger.debug p
        # end
        firstname = ldap_return.givenname[0].to_s
        lastname = ldap_return.sn[0].to_s
        displayname = ldap_return.displayname[0].to_s
        username = params["username"]
        email = ldap_return.mail[0].to_s
 
        if @user = User.where(['login = ?', username]).first
            sign_in_and_redirect @user
        else
            @user = User.create(:login => username)
            sign_in_and_redirect @user
        end
    end

    def failure
      redirect_to :back
    end

 def action_missing(provider)
    # Set up authentication/authorizations here, and distribute tasks
    # that are provider specific to other methods, leaving only tasks
    # that work across all providers in this method. 
  end

end
