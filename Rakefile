def available_stow_directories
  @available_stow_directories ||= Dir.glob("*/").each { |dir| dir.gsub!("/", "") }
end

def selected_stow_directories(specified_directories)
  return available_stow_directories unless specified_directories.any?

  stow_directories, invalid_directories = specified_directories.partition { |directory| available_stow_directories.include?(directory) }

  if invalid_directories.any?
    puts "The following directories are not valid stow directories: #{invalid_directories}"
    puts "Available directories: #{available_stow_directories}"
  end

  stow_directories
end

task :default do |t|
end

task :install do |t, args|
  stow_directories = selected_stow_directories(args.to_a)

  `stow --verbose --target #{Dir.home} #{stow_directories.join(" ")}`
end

task :dry_install do |t, args|
  stow_directories = selected_stow_directories(args.to_a)

  `stow --simulate --verbose --target #{Dir.home} #{stow_directories.join(" ")}`
end

task :uninstall do |t, args|
  stow_directories = selected_stow_directories(args.to_a)

  `stow --verbose --target #{Dir.home} -D #{stow_directories.join(" ")}`
end

task :dry_uninstall do |t, args|
  stow_directories = selected_stow_directories(args.to_a)

  `stow --simulate --verbose --target #{Dir.home} -D #{stow_directories.join(" ")}`
end

task clean_install: [:uninstall, :install]
task dry_clean_install: [:dry_uninstall, :dry_install]
