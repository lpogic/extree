require_relative "./lib/extree/version"

Gem::Specification.new do |s|
  s.name        = "extree"
  s.version     = Extree::VERSION
  s.summary     = "DSL for building various data structures"
  s.description = <<~EOT
    XML-like data definition build in ruby code.
  EOT
  s.authors     = ["Łukasz Pomietło"]
  s.email       = "oficjalnyadreslukasza@gmail.com"
  s.files       = Dir.glob('lib/**/*')
  s.homepage    = "https://github.com/lpogic/extree"
  s.license       = "Zlib"
  s.required_ruby_version     = ">= 3.2.2"
  s.metadata = {
    "documentation_uri" => "https://github.com/lpogic/extree/blob/main/doc/wiki/README.md",
    "homepage_uri" => "https://github.com/lpogic/extree"
  }
end