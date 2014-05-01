Pod::Spec.new do |s|
  s.name         = "ZAFS3Client"
  s.version      = "0.2"
  s.summary      = "AFNetworking Client for the Amazon S3 API."
  s.homepage     = "https://github.com/jallen/AFS3Client"
  s.license      = 'MIT'
  s.author       = { "Jared Allen" => "jared@redcact.us" }
  s.source       = { :git => "https://github.com/zodio/AFS3Client", 
                     :tag => "0.2" }

  s.source_files = 'AFS3Client'
  s.requires_arc = true

  s.dependency 'AFNetworking', '~> 1.3'
end
