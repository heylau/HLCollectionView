#
#  Be sure to run `pod spec lint HLCollectionView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HLCollectionView"
  s.version      = "0.0.1"
s.name         = "HLCollecitonView"
s.version      = "0.0.1"
s.ios.deployment_target = '6.0'
s.osx.deployment_target = '10.8'
s.summary      = "HLCollectionView小框架---OC,随便写写"
s.homepage     = "https://github.com/heylau/HLCollectionView.git"
s.license      = "MIT"


s.source       = { :git => "https://github.com/heylau/HLCollectionView.git", :tag => s.version }
s.source_files  = "HLCollectionVIew/Classes/*.{h,m}"
s.requires_arc = true

end
