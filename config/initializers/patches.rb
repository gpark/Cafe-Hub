Dir[Rails.root.join('lib', 'patches', '**', '*.rb')].each do |file|
  require file.to_s
end