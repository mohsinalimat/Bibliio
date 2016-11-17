platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

target 'Bibliio' do
  pod 'RxRealm'
  pod 'IQKeyboardManagerSwift'
  pod 'TTTAttributedLabel'
  pod 'DZNEmptyDataSet'
  pod 'HockeySDK'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
