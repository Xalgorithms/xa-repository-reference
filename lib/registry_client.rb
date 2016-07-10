require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class RegistryClient
  def initialize(url)
    @conn = Faraday.new(url) do |f|
      f.request(:url_encoded)
      f.request(:json)
      f.response(:json, :content_type => /\bjson$/)
      f.adapter(Faraday.default_adapter)        
    end
  end

  def create_rule(ns, name, version, our_public_id)
    puts "> POST /api/v1/repositories/#{our_public_id}/rules"
    resp = @conn.post("/api/v1/repositories/#{our_public_id}/rules", rule: { ns: ns, name: name, version: version })
    puts "< #{resp.status}"
    if resp.success?
      yield(resp.body.fetch('id'))
    end    
  end

  def delete_rule(repository_public_id, public_id)
    puts "> DELETE /api/v1/repositories/#{repository_public_id}/rules/#{public_id}"
    resp = @conn.delete("/api/v1/repositories/#{repository_public_id}/rules/#{public_id}")
    puts "< #{resp.status}"
    if resp.success?
      yield
    end
  end
  
  def register(url)
    puts "> POST /api/v1/repositories"
    resp = @conn.post('/api/v1/repositories', repository: { url: url })
    puts "< #{resp.status}"
    if resp.success?
      yield(resp.body.fetch('public_id'))
    end
  end

  def deregister(public_id)
    puts '> DELETE /api/v1/repositories'
    resp = @conn.delete("/api/v1/repositories/#{public_id}")
    puts "< #{resp.status}"
  end
end
