require 'xcodeproj'
project_path = '/Users/masahiroaoki/Developer/artisan_app/ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

development_team = ARGV[0]
provisioning_profile_specifier = ARGV[1]

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
