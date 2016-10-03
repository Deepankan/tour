YourLabelClass = Struct.new :label_id, :some_config
Whitelabel.from_file Rails.root.join("config/whitelabel.yaml")