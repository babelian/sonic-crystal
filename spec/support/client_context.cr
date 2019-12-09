macro include_context_client
  let(client) { Sonic::Client.new(host, port, password) }
  let(host) { ENV["SONIC_HOST"] }
  let(port) { ENV["SONIC_PORT"] }
  let(password) { ENV["SONIC_PASSWORD"] }
end