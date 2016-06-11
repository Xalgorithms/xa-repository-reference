module OrganizeHelper
  def organise(collection, length)
    if collection
      [collection[0...length]] + organise(collection[length..-1], length)
    else
      []
    end    
  end
end
