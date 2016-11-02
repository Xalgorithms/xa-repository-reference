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

  def self.update(push_id)
  end

  private

  def self.scan_all(repo)
    br = repo.branches['master']
    ver = br.target.oid[0..7]
    to_scan = {}
    br.target.tree.each_tree do |o|
      Rails.logger.debug("scanning tree (name=#{o[:name]}; oid=#{o[:oid]}; ver=#{ver})")
      files = repo.lookup(o[:oid]).inject([]) do |fs, o|
        n = o[:name]
        ext = File.extname(n)
        rt = ext[1..-1].to_sym
        
        Rails.logger.debug("scanning file (name=#{o[:name]}; rt=#{rt}; oid=#{o[:oid]})")
        blob = repo.lookup(o[:oid])
        vals = { name: File.basename(n, ext), type: rt, oid: o[:oid], ver: ver }
        Rule::TYPES.include?(rt) ? fs.push(vals) : fs
      end
      
      to_scan = to_scan.merge(o[:name] => files)
    end

    to_scan
  end

  def self.add_all(repo, all)
    Rails.logger.info('adding new objects')
    all.each do |ns_name, entries|
      nsm = Namespace.find_or_create_by(name: ns_name)

      ap entries
      vers = entries.inject({}) do |o, e|
        o.merge(e[:name] => e[:ver])
      end

      ap vers
      entries.each do |o|
        blob = repo.lookup(o[:oid])
        content = :xalgo == o[:type] ? replace_versions(blob.content, vers) : blob.content
        RuleService.create(nsm, o[:name], content, o[:type], o[:ver])
      end if nsm
    end
  end

  def self.replace_versions(content, vers)
    content.split(/[\r]?\n/).map do |ln|
      m = /\{((?:\w+))_version\}/.match(ln)
      if m
        ln = ln.gsub("{#{m[1]}_version}", vers[m[1]].to_s)
      end

      ln
    end.join("\n")
  end
end
