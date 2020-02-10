Pod::Spec.new do |s|
    s.name = "TRPUIKit"
    s.version = "1.4.0"
    s.summary = "Tripian iOS Framework"
    s.homepage = "https://www.tripian.com"
    s.license =  s.license = { :type => "BSD" }
    s.author = { "Tripian" => "necati@tripian.com" }
    s.source       = {
        :http => "https://tripian-mobile-sdk.s3.us-east-2.amazonaws.com/trpuikit/1.4.0/TRPUIKit.zip",
        :flatten => true
      }
    s.module_name = "TRPUIKit"
    s.exclude_files = "Classes/Exclude"
    s.ios.deployment_target = "11.0"
    s.platform = :ios, "11.0"
    s.vendored_frameworks = "TRPUIKit/TRPUIKit.framework"
    s.requires_arc = true
    s.frameworks = "UIKit"
end
    