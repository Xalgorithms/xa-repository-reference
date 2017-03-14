module PublicModelChecks
  include Randomness

  def destroy_many(cls)
    cls.each { |cl| cl.destroy_all }
  end
  
  def verify_public_id(n)
    m = create(n)
    expect(m.public_id).to_not be_nil

    id = UUID.generate
    m = create(n, public_id: id)
    expect(m.public_id).to eql(id)    
  end

  def verify_belongs_to(n, pn)
    rand_array_of_models(pn).each do |pm|
      m = create(n, pn => pm)
      expect(m.send(pn)).to eql(pm)
    end
  end

  def verify_has_many(n, cn)
    rand_array_of_models(n).each do |m|
      cms = rand_array_of_models(cn, n => m)
      cms.each do |cm|
        expect(m.send(cn.to_s.pluralize)).to include(cm)
      end
    end
  end
end
