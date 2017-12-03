platform :ios, "10.0"

use_frameworks!
swift_version = '4.0'
def import_pods
    pod 'PromiseKit/Alamofire', '~> 4.0'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'AlamofireImage', '~> 3.1'
    pod 'PKHUD', '5.0'
    pod 'ReactiveCocoa', '~> 7.0'
end

target "ViperDemo" do
    import_pods
end

target "ViperDemoTests" do
    import_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            # these libs work now only with Swift3.2 in Xcode9
            if ['ObjectMapper'].include? target.name
                configuration.build_settings['SWIFT_VERSION'] = "3.2"
            end
        end
    end
end
