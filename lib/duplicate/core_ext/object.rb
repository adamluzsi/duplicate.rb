require 'duplicate'
Object.class_eval do

  def duplicate(object)
    return ::Duplicate.duplicate(object)
  end

end