# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
#source 'https://github.com/CocoaPods/Specs.git'
source 'https://cdn.cocoapods.org/'
target 'TicketMasterTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 5.6.2'
  pod 'SDWebImage', '~> 5.15.0'
  pod 'RealmSwift', '~> 10.32.2'
  pod 'ReachabilitySwift'

    target 'TicketMasterTestTests' do
        inherit! :search_paths
  	pod 'Alamofire', '~> 5.6.2'
  	pod 'SDWebImage', '~> 5.15.0'
  	pod 'RealmSwift', '~> 10.32.2'
 	pod 'ReachabilitySwift'
    end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
    target.build_configurations.each do |config|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
    end
  end
end
