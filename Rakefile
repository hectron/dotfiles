def available_stow_directories
  @available_stow_directories ||= Dir
    .glob("*/")
    .each { |dir| dir.gsub!("/", "") }
end

def selected_stow_directories(specified_directories)
  return available_stow_directories unless specified_directories.any?

  invalid_directories = specified_directories - available_stow_directories

  if invalid_directories.any?
    puts "The following directories are not valid stow directories: #{invalid_directories}"
    puts "Available directories: #{available_stow_directories}"
  end

  specified_directories & available_stow_directories
end

def stow(dirs, target: Dir.home, delete: false, verbose: true, simulate: false)
  flags = [].tap do |f|
    f << "--verbose" if verbose
    f << "--simulate" if simulate
    f << "--target #{target}"
    f << "--delete" if delete
  end

  `stow #{flags.join(" ")} #{dirs.join(" ")}`
end

task :default do |t|
end

task :install do |t, args|
  directories = selected_stow_directories(args.to_a)

  stow directories
end

task :dry_install do |t, args|
  directories = selected_stow_directories(args.to_a)

  stow directories, simulate: true
end

task :uninstall do |t, args|
  directories = selected_stow_directories(args.to_a)

  stow directories, delete: true
end

task :dry_uninstall do |t, args|
  directories = selected_stow_directories(args.to_a)

  stow directories, simulate: true, delete: true
end

task clean_install: [:uninstall, :install]
task dry_clean_install: [:dry_uninstall, :dry_install]
