# name: ionisx
# about: Adds ionisx authentication support to Discourse
# version: 0.1
# authors: Franck Chevallereau

require 'auth/oauth2_authenticator'
require 'omniauth-oauth2'

Rails.application.config.action_dispatch.default_headers.merge!({'X-Frame-Options' => 'ALLOWALL'})

class IonisxAuthenticator < ::Auth::OAuth2Authenticator
  def register_middleware(omniauth)
    omniauth.provider :ionisx, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.ionisx_client_id
      strategy.options[:client_secret] = SiteSetting.ionisx_client_secret
      strategy.options[:client_options] = { :site => SiteSetting.ionisx_site_url,
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token',
        :userinfo_url => '/api/user/me'
      }
    }
  end
end

class OmniAuth::Strategies::Ionisx < OmniAuth::Strategies::OAuth2

  option :name, 'ionisx'

  uid { raw_info['_id'] }

  info do
    {
      :name => raw_info['name'],
      :username => raw_info['username'],
      :email => raw_info['primaryEmail']
    }
  end

  extra do
    {
      'raw_info' => raw_info
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/api/user/me').parsed
  end
end

auth_provider :title => 'Sign in with IONISx',
    :message => 'Log in using your IONISx account. (Make sure your popup blocker is disabled)',
    :frame_width => 920,
    :frame_height => 800,
    :authenticator => IonisxAuthenticator.new('ionisx', trusted: true, auto_create_account: true)
