require 'fileutils'
require 'depo'

namespace :dojo do
  desc "Install dojo"
  task :install=>:environment do
    Dir.chdir(RAILS_ROOT)
    version = Depo.config.dojo_version
    system "dojofy #{Depo.config.src_path} #{version}"
  end

  desc "Generate build profile"
  task :build_profile=>:environment do
    Depo::Build.generate_profile(:rails_root=>RAILS_ROOT)
  end

  desc "Build dojo"
  task :build=>:build_profile do
    profile_file = File.join(RAILS_ROOT,Depo.config.profile_path)
    Dir.chdir File.join(RAILS_ROOT,Depo.config.buildscripts_path)
    release_dir=File.join(RAILS_ROOT,Depo.config.builds_path)
    FileUtils.mkdir_p(release_dir) unless File.exists? release_dir

    options=Depo.config.build_options.get_options.map{ |key, val| "#{key}=#{val}"}.join ' '
    build_name='build_'+DateTime.now.to_s.gsub(/[^A-Za-z0-9_]/, '_')
    puts "Start building to #{release_dir}/#{build_name}."
    cmd= "./build.sh profileFile=#{profile_file} releaseDir=#{release_dir} releaseName=#{build_name} #{options} action=release"
    puts cmd
    system cmd
  end
end
