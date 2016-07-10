class RegistrySerializer
  def self.as_json(registry)
    {
      id: registry.public_id,
      url: registry.url,
      our_url: registry.our_url,
      registered_public_id: registry.registered_public_id,
    }
  end
end
