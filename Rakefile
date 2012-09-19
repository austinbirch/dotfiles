require 'rake'
require 'time'

desc "links the dotfiles into the user's home directory"
task :link_dotfiles do
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

task :default => 'link_dotfiles'

