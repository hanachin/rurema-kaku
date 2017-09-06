require "rake/clean"
require "open3"

CLEAN.include('public/rurema.html')
CLOBBER.include('doctree', 'template', 'public/theme')

desc "clone rurema/doctree"
directory "doctree" do
  sh "git clone --depth 10 https://github.com/rurema/doctree.git doctree"
end

task :bundle_install do
  sh "bundle check || bundle install"
end

directory "template" => :bundle_install do
  o, s = Open3.capture2e("bundle exec gem which bitclust")
  raise o unless s.success?
  template_path = File.join(File.dirname(File.dirname(o)), "data/bitclust/template")
  cp_r(template_path, 'template')
end

directory "public"
directory "public/theme" => %i(bundle_install public) do
  o, s = Open3.capture2e("bundle exec gem which bitclust")
  raise o unless s.success?
  theme_path = File.join(File.dirname(File.dirname(o)), "theme")
  cp_r(theme_path, File.join('public', 'theme'))
end

desc "setup rurema reload"
task setup: %i(doctree template public/theme)

task default: :setup
