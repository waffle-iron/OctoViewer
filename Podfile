use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

def shared_pods
  pod 'Alamofire'
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'
  pod 'ReusableViews'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'SwiftLint'
end

def testing_pods
  pod 'Nimble'
  pod 'Quick'
  pod 'RxBlocking'
  pod 'RxTest'
end

target 'OctoViewer' do
  shared_pods
end

target 'OctoViewerTests' do
  shared_pods
  testing_pods
end
