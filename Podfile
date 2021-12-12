source 'https://github.com/Budi77Darmawan/iOS-CommonExtPodspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
workspace 'MoviesAppWithCI'

target 'MoviesAppWithCI' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  # Pods for MoviesAppWithCI
  pod 'CommonExt'
  pod 'Alamofire', '~> 5.2'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'SDWebImage', '~> 5.12.0'
  pod 'RealmSwift'
  pod 'SwiftLint'
  
end

target 'SharedView' do
  project './Modules/SharedView/SharedView'
end

target 'Core' do
  project './Modules/Core/Core'
  pod 'Alamofire', '~> 5.2'
  pod 'RealmSwift'
  pod 'RxSwift', '~> 5'
  pod 'SDWebImage', '~> 5.12.0'
end

target 'Home' do
  project './Modules/Home/Home'
  pod 'CommonExt'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RealmSwift'
end

target 'Bookmark' do
  project './Modules/Bookmark/Bookmark'
  pod 'CommonExt'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RealmSwift'
end

