
def join(*args)
  path = File.expand_path(File.join(*args))
  raise "Path doesn't exist: #{path}" unless File.exist?(path)
  path
end
