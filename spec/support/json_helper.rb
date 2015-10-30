module JsonHelper
  def load_json_sample(path)
    ::JSON.parse File.read(File.expand_path('../../samples/' << path, __FILE__))
  end
end
