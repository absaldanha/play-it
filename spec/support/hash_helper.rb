module HashHelper
  def symbolize_keys(hash)
    Hash[hash.map { |key, value| [key.to_sym, value] }]
  end
end
