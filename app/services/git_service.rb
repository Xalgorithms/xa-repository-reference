require 'rugged'

class GitService
  def self.init(id)
    grm = GitRepository.find(id)
    if grm
      repo = Rugged::Repository.clone_at(grm.url, File.join('/tmp', grm.name), bare: true)
    end
  end

  def self.clean(id)
    grm = GitRepository.find(id)
    if grm
      FileUtils.rm_rf(File.join('/tmp', grm.name))
    end
  end
end
