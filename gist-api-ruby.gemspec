# frozen_string_literal: true

require_relative "lib/gist/version"

Gem::Specification.new do |spec|
  spec.name = "gist-api-ruby"
  spec.version = Gist::VERSION
  spec.authors = ["Getgist"]
  spec.email = ["support@getgist.com"]

  spec.summary = "Smart way to access Gist with ruby libraries"
  spec.description = "This will help you to access the gist Developers API easily with simple ruby"
  spec.homepage = "https://github.com/gistplatform/gist-api-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/gistplatform/gist-api-ruby"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gistplatform/gist-api-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/gistplatform/gist-api-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
