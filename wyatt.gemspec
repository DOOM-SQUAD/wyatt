Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '2.0.3'

  s.name              = 'wyatt'
  s.version           = '0.0.0'
  s.date              = '2013-05-17'

  s.description   = %q{A multi-layer communications base for ERP services.}
  s.summary       = %q{A multi-layer communications base for ERP services.}

  s.authors       = ["James Christie", "Christopher M. Hobbs"]
  s.email         = ["jchristie@acumenholdings.com", "chobbs@acumenholdings.com"]
  s.homepage      = "https://github.com/acumenbrands/wyatt"

  s.require_paths = %w[lib]

  s.extra_rdoc_files = %w[README.md LICENSE.md]

  s.add_dependency 'addressable'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
  ]
  # = MANIFEST =

  s.test_files    = s.files.grep(%r{^spec/})
end
