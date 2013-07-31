require 'rake'

def setup_paths
  env_dest = ENV['DEST']

  if env_dest
    @dest_path = File.expand_path(env_dest, File.dirname(__FILE__))
    system "mkdir -p #{@dest_path}" unless File.directory?(@dest_path)
  else
    @dest_path = ENV['HOME']
  end

  @source_path = File.expand_path(".", File.dirname(__FILE__))
end

def link_file(source, destination)
  #puts "source - #{source}"
  #puts "destination - #{destination}"
  #puts ""
  
  system "ln -s #{source} #{destination}"
end

def replace_file(source, destination)
  if File.exist?(destination)
    puts "#{destination} existed, replacing..."
    system "rm -rf #{destination}"
  end
  link_file(source, destination)
end

namespace :dotfiles do
  def link_dotfiles(force = false)
    puts "Linking dotfiles..."

    setup_paths() if @dest_path.nil? or @source_path.nil?
    
    files = [
      'vimrc',
      'tmux.conf',
      'zshrc',
      'vim',
			'irssi',
      'oh-my-zsh',
      'custom',
      'gitconfig',
      'emacs.d'
    ]

    files.each do |file|
      source = File.join(@source_path, "#{file}")
      destination = File.join(@dest_path, ".#{file}")

      if force
        replace_file(source, destination)
      else
        link_file(source, destination)
      end
    end
    
    puts "Linking dotfiles complete."
  end

  desc "Links the dotfiles into the user's home directory (or env DEST)"
  task :link do
    link_dotfiles()
  end

  desc "Same as :link but overwrites any conflicting files"
  task :link_force do
    link_dotfiles(true)
  end
end

namespace :fonts do
  def link_fonts(force = false)
    puts "Linking fonts..."

    os_type = RbConfig::CONFIG['host_os']
    case os_type
    when /linux/i

      setup_paths() if @dest_path.nil? or @source_path.nil?

      unless File.directory?(File.join(@dest_path, ".fonts/"))
        system "mkdir -p #{File.join(@dest_path, '.fonts/')}"
      end

      fonts_source = File.join(@source_path, "fonts/")
      Dir.foreach(fonts_source) do |file|
        next if file == '.' or file == '..'

        source = File.join(fonts_source, "#{file}")
        destination = File.join(@dest_path, ".fonts/#{file}")

        if force
          replace_file(source, destination)
        else
          link_file(source, destination)
        end
      end

      puts "Linking fonts complete, you may need to rebuild your font cache."
    else
      puts "Font installation not supported on this OS"
    end
  end

  desc "Links the fonts into the appropriate directory"
  task :link do
    link_fonts()
  end

  desc "Same as :link, but overwrite any conflicting files"
  task :link_force do
    link_fonts(true)
  end

end

# default etc
task :all => ["dotfiles:link", "fonts:link"]
task :default => ["dotfiles:link"]

