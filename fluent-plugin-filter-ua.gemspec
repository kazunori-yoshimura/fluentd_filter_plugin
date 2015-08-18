Gem::Specification.new do |spec|
  spec.name = "fluent-filter-ua"
#  spec.version       = FluentdFilterPlugin::VERSION

  spec.authors       = ["kazunori-yoshimura"]
  spec.email         = ["hot.vegetable.juice@gmail.com"]

  spec.summary       = "A fluentd plugin to filter logs using a spider list"
  spec.description   = "A fluentd plugin to filter logs using a spider list"
  spec.homepage      = "https://github.com/kazunori-yoshimura/fluentd_filter_plugin"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this spec to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public spec pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

end
