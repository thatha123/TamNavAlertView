Pod::Spec.new do |s|
    s.name         = "TamNavAlertView"
    s.version      = "0.0.1"
    s.summary      = "A short description of TamNavAlertView."
    s.homepage      =  'https://github.com/thatha123/TamNavAlertView'
    s.license       =  'MIT'
    s.authors       = {'Tam' => '1558842407@qq.com'}
    s.platform      =  :ios,'8.0'
    s.source        = {:git => 'https://github.com/thatha123/TamNavAlertView.git',:tag => "v#{s.version}" }
    s.source_files  =  'TamNavAlertViewDemo/TamNavAlertView/*.{h,m}'
    s.requires_arc  =  true
end

