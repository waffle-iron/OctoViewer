use_frameworks!

def shared_pods
  pod 'Alamofire'
  pod 'Moya'
  pod 'Moya-Gloss'
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
