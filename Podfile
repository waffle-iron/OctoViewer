use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

def shared_pods
  pod 'Alamofire'
  pod 'Moya/ReactiveSwift'
  pod 'Moya-Gloss/ReactiveSwift'
  pod 'ReactiveCocoa'
  pod 'ReactiveSwift'
  pod 'ReusableViews'
  pod 'SwiftLint'
end

def testing_pods
  pod 'Nimble'
  pod 'Quick'
end

target 'OctoViewer' do
  shared_pods
end

target 'OctoViewerTests' do
  shared_pods
  testing_pods
end
