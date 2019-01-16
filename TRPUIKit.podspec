Pod::Spec.new do |s|
s.name = 'TRPUIKit'
s.version = '1.0.3'
s.summary = 'POD_DESCRIPTION'
s.homepage = 'https://github.com/necatievrenyasar'

s.license =  s.license = { :type => 'MIT', :file => '/Users/evrenyasar/Xcode/TRPUIKit/LICENSE' }
s.author = { 'Evren Yaşar' => 'necatievren@gmail.com' }
s.platform = :ios, '10.0'
#s.source = { :path => 'TRPUIKit', :tag => s.version.to_s }
s.source = { :git => 'https://necatievrenyasar:N-pibolu13@github.com/Tripian-inc/TRPUIKit.git', :tag => '1.0.4' }
s.source_files = 'TRPUIKit/**/**/*.{h,m,swift,xcdatamodeld}'
s.exclude_files = 'TRPUIKit/*.plist'
s.frameworks = 'UIKit'
s.swift_version = "4.2" 
s.requires_arc = true
end