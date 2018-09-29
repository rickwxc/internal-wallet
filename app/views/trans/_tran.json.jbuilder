json.extract! tran, :id, :source_entity_type, :source_entity_id, :target_entity_type, :target_entity_id, :type, :amount, :created_at, :updated_at
json.url tran_url(tran, format: :json)
