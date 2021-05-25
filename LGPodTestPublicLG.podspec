
Pod::Spec.new do |spec|


  spec.name         = "LGPodTestPublicLG"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of LGPodTestPublicLG."
  spec.description  = <<-DESC
  项目描述，一些介绍。A short description of LGPodTestPublicLG.
                   DESC //这里的描述，必须比s.summary的长度要长。

  spec.homepage     = "https://github.com/lipopli/LGPodTestPublicLG"
  spec.license      = "MIT"
  spec.author       = { "李功骄" => "381216970qq.com" }

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/lipopli/LGPodTestPublicLG.git", :tag => s.version } //git => 远程仓库的clone地址, tag取版本号就行
  spec.requires_arc = true //ARC
  spec.source_files  = 'Classes/*.{swift}'
end
