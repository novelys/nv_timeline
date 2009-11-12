# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nv_timeline}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yann Klis", "David Bourguignon", "Thierry Stiegler"]
  s.date = %q{2009-09-25}
  s.description = %q{Easily build timelines}
  s.email = %q{david.bourguignon@novelys.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "generators/nv_timeline/USAGE",
     "generators/nv_timeline/templates/migration.rb",
     "generators/nv_timeline/templates/model.rb",
     "generators/nv_timeline/nv_timeline_generator.rb",
     "init.rb",
     "lib/nv_timeline.rb",
     "lib/nv_timeline/fires.rb",
     "lib/nv_timeline/macros.rb",
     "lib/nv_timeline/matchers.rb",
     "shoulda_macros/nv_timeline_shoulda.rb",
     "nv_timeline.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/novelys/nv_timeline}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Easily build timelines}
  s.test_files = [
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
