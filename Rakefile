require 'fileutils'

task :default => :install

vimfiles = if ENV['VIMFILES']
             ENV['VIMFILES']
           elsif RUBY_PLATFORM =~ /(win|w)32$/
             File.expand_path("~/vimfiles")
           else
             File.expand_path("~/.vim")
           end

files = lambda do
  Dir['*/*'].map do |file|
    [file, File.join(vimfiles, file)]
  end
end

desc "Install to #{vimfiles.sub(ENV['HOME'], '~')}"
task :install do
  files[].map do |file, target_file|
    FileUtils.mkdir_p(File.dirname(target_file))
    FileUtils.cp(file, target_file, :verbose => true)
  end
end

desc "Install by symlinking"
task :symlink do
  pwd = Dir.pwd
  files[].map do |file, target_file|
    FileUtils.mkdir_p(File.dirname(target_file))
    FileUtils.ln_sf(File.expand_path(file, pwd), target_file, :verbose => true)
  end
end

desc "Uninstall"
task :uninstall do
  files[].map do |file, target_file|
    FileUtils.rm(target_file, :verbose => true)
  end
end
