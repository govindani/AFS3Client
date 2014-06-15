Pod::Spec.new do |s|
  s.name         = "AFS3Client"
  s.version      = "0.2.3"
  s.summary      = "AFNetworking Client for the Amazon S3 API."
  s.homepage     = "https://github.com/jallen/AFS3Client"
  s.license      = 'MIT'
  s.author       = { "Jared Allen" => "jared@redcact.us" }
  s.source       = { :git => "https://github.com/jai/AFS3Client.git", 
                     :tag => "0.2.3" }

  s.source_files = 'AFS3Client'
  s.requires_arc = true
  s.platform     = :ios, "5.0"
  s.framework 	 = 'SystemConfiguration','MobileCoreServices'
  s.dependency 'AFNetworking', '~> 1.3'

end
