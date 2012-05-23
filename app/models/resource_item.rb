class ResourceItem < ActiveRecord::Base
  belongs_to :resource_cate
  attr_accessor :upload_file

  def self.type_hash
  	{1 => 'picture', 2 => 'file', 3 => 'video', 4 => 'audio', 5 => 'flash'}
  end

  def self.recent(count)
    ResourceItem.order("updated_at DESC").limit(count)
  end
end
