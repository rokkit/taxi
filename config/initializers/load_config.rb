path = File.join(Rails.root, "config/application.yml")
APP = YAML.load(File.read(path))[Rails.env]