
Pod::Spec.new do |spec|
  spec.name         = "LGPodTestPublicLG"
  spec.version      = "0.0.5"
  spec.summary      = "A Short Test"
  spec.description  = <<-DESC
  项目描述，一些介绍。A short description of LGPodTestPublicLG.
                   DESC
  spec.homepage     = "https://github.com/lipopli/LGPodTestPublicLG"
  spec.license      = "MIT"
  spec.author       = { "李功骄" => "381216970qq.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/lipopli/LGPodTestPublicLG.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes/**/*.{h,m,swift}"
  spec.swift_version = '4.0'
end
