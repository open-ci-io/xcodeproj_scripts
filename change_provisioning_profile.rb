require 'xcodeproj'

project_path = ARGV[0]
development_team = ARGV[1]
provisioning_profile_specifier = ARGV[2]

project = Xcodeproj::Project.open(project_path)

project.targets.each do |target|
  target.build_configurations.each do |config|
    if config.name == 'Release'
      config.build_settings['CODE_SIGN_STYLE'] = 'Manual'
      config.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'iPhone Distribution'
      config.build_settings['DEVELOPMENT_TEAM'] = ''
      config.build_settings['DEVELOPMENT_TEAM[sdk=iphoneos*]'] = development_team
      config.build_settings['PROVISIONING_PROFILE_SPECIFIER[sdk=iphoneos*]'] = provisioning_profile_specifier
    end
  end
end

project.save
