require 'rake'
require 'time'

namespace :dotfiles do
  desc "links the dotfiles into the user's home directory"
  task :link do
    puts "Linking dotfiles..."

    timestamp = Time.now.to_i

    files = [
      'vimrc',
      'tmux.conf',
      'zshrc',
      'vim',
      'oh-my-zsh',
      'custom'
    ]

    files.each do |file|
      dest_path = ENV['DEST']

      if dest_path.nil?
        dest_file = File.join(ENV['HOME'], ".#{file}")
      else
        dest_file = File.join(dest_path, ".#{file}")
      end

      # move to a timestamped backup if it already exists
      if File.exist?(dest_file)
        backup_file = "#{dest_file}-#{timestamp}.backup"
        system "mv #{dest_file} #{backup_file}"
        puts "Backed up #{dest_file} to #{backup_file}"
      end

      # link the file
      system "ln -s #{Dir.pwd}/#{file} #{dest_file}"
      puts "Linked file."
    end

    puts "Linking complete.\n"
  end
end

namespace :fonts do
  desc "installs fonts if on a supported platform"
  task :install do
    timestamp = Time.now.to_i

    os = RbConfig::CONFIG['host_os']

    case os
    when /darwin/i
      puts "Font installation on #{os} not supported."
      return
    when /linux/i
      puts "Installing fonts..."
    end
  end
end

task :default => 'dotfiles:link'
task :all => ['dotfiles:link', 'fonts:install']

