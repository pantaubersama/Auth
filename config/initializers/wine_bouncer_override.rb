WineBouncer::OAuth2.class_eval do

  def doorkeeper_authorize!(*scopes)
    scopes = Doorkeeper.configuration.default_scopes if scopes.empty?
    valid_doorkeeper_token?(*scopes)
  end

  def valid_doorkeeper_token?(*scopes)
    token = if request.headers["Authorization"].present?
      request.headers["Authorization"].include?("bearer") ? request.headers["Authorization"].try("split", "bearer").try(:last).try(:strip) : request.headers["Authorization"]
    else
      request.parameters["access_token"]
    end
    access = Doorkeeper::AccessToken.find_by(token: token)
    unless access.present?
      raise WineBouncer::Errors::OAuthUnauthorizedError, {name: WineBouncer::Errors::OAuthUnauthorizedError.class.to_s, state: :unauthorized, description: "Access token unauthorized"}
    end
    if access.application.confidential == false
      user = User.find_by(id: access.resource_owner_id)
      if access.present? && access.accessible? && user.present?
        the_scopes       = Doorkeeper::OAuth::Scopes.from_array(user.scopes)
        no_scope_defined = scopes.blank? || scopes.any? {|s| the_scopes.exists?(s.to_s)}
        unless no_scope_defined
          raise WineBouncer::Errors::OAuthForbiddenError, {name: WineBouncer::Errors::OAuthForbiddenError.class.to_s, state: :forbidden, description: scopes.join(", ")}
        end
      else
        # throw expired or revoked token
        raise WineBouncer::Errors::OAuthUnauthorizedError, {name: WineBouncer::Errors::OAuthUnauthorizedError.class.to_s, state: :unauthorized, description: "Access token unauthorized"}
      end
      $me = user
    else
      user = User.find_by(id: access.resource_owner_id)
      $me = user if user.present?
      if access.present? && access.accessible?
        the_scopes       = Doorkeeper::OAuth::Scopes.from_array(access.scopes)
        no_scope_defined = scopes.blank? || scopes.any? {|s| the_scopes.exists?(s.to_s)}
        unless no_scope_defined
          raise WineBouncer::Errors::OAuthForbiddenError, {name: WineBouncer::Errors::OAuthForbiddenError.class.to_s, state: :forbidden, description: scopes.join(", ")}
        end
      else
        raise WineBouncer::Errors::OAuthUnauthorizedError, {name: WineBouncer::Errors::OAuthUnauthorizedError.class.to_s, state: :unauthorized, description: "Access token unauthorized"}
      end
    end
  end
end
