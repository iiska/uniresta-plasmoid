
desc "Build plasmoid package"
task :package do
  system 'zip -r ../uniresta-plasmoid.zip metadata.desktop contents/code/main.rb'
end

desc "Re-install plasmoid"
task :reinstall => :package do
  # Remove old version
  system 'plasmapkg -r uniresta-plasmoid'
  # Install new
  system 'plasmapkg -i ../uniresta-plasmoid.zip'
end

