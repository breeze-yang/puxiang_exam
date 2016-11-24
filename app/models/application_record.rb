class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.by_id(id)
    self.fetch_by_uniq_keys(id: id)
  end

end
