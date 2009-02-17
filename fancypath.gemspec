# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fancypath}
  s.version = "0.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Myles Byrne", "Chris Lloyd"]
  s.autorequire = %q{fancypath}
  s.date = %q{2009-02-17}
  s.description = %q{Extensions for the Pathname library.}
  s.email = %q{myles@ducknewmedia.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["LICENSE", "README.rdoc", "Rakefile", "lib/fancypath.rb", "spec/fancypath_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://ducknewmedia.com/fancypath}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Extensions for the Pathname library.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
