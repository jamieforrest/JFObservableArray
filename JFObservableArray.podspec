#
# Be sure to run `pod lib lint JFObservableArray.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JFObservableArray"
  s.version          = "0.1.1"
  s.summary          = "JFObservableArray is a KVO-compliant array wrapper that informs observers of changes to the array's underlying structure."
  s.description      = <<-DESC
                        `NSMutableArray` is not KVO-compliant, meaning that you cannot observe changes to the underlying structure of the array. `JFObservableArray` adds KVO-compliance to `NSMutableArray`, informing clients of inserted, replaced, and removed objects in the array. This is useful, for example, in cases where you might need to bind a view in the UI to a list of objects (e.g., `UITableView`).
                       DESC
  s.homepage         = "https://github.com/jamieforrest/JFObservableArray"
  s.license          = 'MIT'
  s.author           = { "Jamie Forrest" => "jamie@jamieforrest.com" }
  s.source           = { :git => "https://github.com/jamieforrest/JFObservableArray.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jamieforrest'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
end
