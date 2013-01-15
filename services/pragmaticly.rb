class Service::Pragmaticly < Service
  string :project_uid, :token
  white_list :project_uid

  def receive_push
    raise_config_error "Must provide a project uid." if data['project_uid'].to_s.empty?
    raise_config_error "Must provide a token." if data['token'].to_s.empty?

    http.headers['Content-Type'] = 'application/json'

    http_post "https://pragmatic.ly/projects/#{data['project_uid']}/hooks",
      { :token => data['token'], :payload => JSON.generate(payload) }
  end
end