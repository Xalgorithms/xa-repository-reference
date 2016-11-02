require 'rugged'

class GitService
  def self.init(id)
    grm = GitRepository.find(id)
    if grm
      repo = Rugged::Repository.clone_at(grm.url, File.join('/tmp', grm.name), bare: true)
      Rails.logger.info("scanning repo on master branch (url=#{grm.url})")
      add_all(repo, scan_all(repo))
    end
  end

  def self.clean(id)
    grm = GitRepository.find(id)
    if grm
      FileUtils.rm_rf(File.join('/tmp', grm.name))
    end
  end

  private

  def self.scan_all(repo)
    br = repo.branches['master']
    to_scan = {}
    br.target.tree.each do |o|
      if o[:type] == :tree
        Rails.logger.debug("scanning tree (name=#{o[:name]}; oid=#{o[:oid]})")
        files = repo.lookup(o[:oid]).inject({}) do |fs, o|
          n = o[:name]
          ext = File.extname(n)
          rt = ext[1..-1].to_sym

          Rails.logger.debug("scanning file (name=#{o[:name]}; rt=#{rt}; oid=#{o[:oid]})")
          blob = repo.lookup(o[:oid])
          vals = { name: File.basename(n, ext), oid: o[:oid] }
          Rule::TYPES.include?(rt) ? fs.merge(rt => fs.fetch(rt, []).push(vals)) : fs
        end

        to_scan = to_scan.merge(o[:name] => files)
      end
    end

    to_scan
  end

  def self.add_all(repo, all)
    Rails.logger.info('adding new objects')
    all.each do |ns_name, types|
      nsm = Namespace.find_or_create_by(name: ns_name)
      types.each do |rt, vals|
        vals.each do |v|
          blob = repo.lookup(v[:oid])
          RuleService.create(nsm, v[:name], blob.content, rt)
        end
      end if nsm
    end
  end
end
