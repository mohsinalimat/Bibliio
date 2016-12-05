platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def shared_pods
  pod 'RealmSwift'
  pod 'RxSwift',  '~> 3.0'
  pod 'RxCocoa',  '~> 3.0'
end

def app_pods
  pod 'IQKeyboardManagerSwift'
  pod 'TTTAttributedLabel'
  pod 'DZNEmptyDataSet'
  pod 'HockeySDK'
end

plugin 'cocoapods-keys', {
  :project => "Bibliio",
  :keys => [
    "BibliioISBNAPIKey"
  ]}

target 'Bibliio' do
  shared_pods
  app_pods
end

target 'BibliioTests' do
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
