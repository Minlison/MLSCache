Pod::Spec.new do |s|
  s.name         = "MLSCache"
  s.version      = "1.0.0"
  s.summary      = "MLSCache"
  s.description  = <<-DESC
                    MLSCache 组件化中心，统一缓存管理模块
                   DESC

  s.homepage     = "https://github.com/Minlison/MLSCache.git"
  s.license      = "MIT"
  s.author       = { "Minlison" => "yuanhang@minlison.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Minlison/MLSCache.git", :tag => "v#{s.version}" }
  s.documentation_url = "https://www.minlison.cn/article/mlscache"
  s.requires_arc = true
  s.static_framework = true
  s.source_files  = "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/Manager/**/*.h"
end
