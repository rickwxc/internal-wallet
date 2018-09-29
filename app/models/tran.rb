class Tran < ApplicationRecord
  belongs_to :source_entity, polymorphic: true
  belongs_to :target_entity, polymorphic: true
end
