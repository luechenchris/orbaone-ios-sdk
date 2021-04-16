
Pod::Spec.new do |spec|
  spec.name         = "OrbaOneSdk"
  spec.version      = "0.0.1"
  spec.summary      = "The Official Orba One iOS pod for integrating document and video capture."
  spec.description  = <<-DESC
  Orba One is a suite of customizable user identification tools including liveness detection, document verification, facial recognition, and more. These tools are combined to estimate the authenticity of a User's Identity shared with you.
                   DESC
  spec.homepage     = "https://github.com/luechenchris/orbaone-ios-sdk"
  spec.license      = { :type => 'Commercial', :text => "See https://www.orbaone.com/" }
  spec.author       = { "Orba One" => "luechen@orba.io" }
  spec.platform     = :ios
  spec.ios.deployment_target  = '13.0'
  spec.swift_version = '5.0'
  spec.source       = { :http => "https://www.dropbox.com/s/d6phw9gy530fgp8/OrbaOneSdk.zip?dl=1"}
  spec.vendored_frameworks = "#{spec.name}.xcframework"
  spec.frameworks = [
    "Foundation",
    "UIKit",
    "AVFoundation"
  ]
  spec.dependency "Alamofire", "~> 5.4"
end
