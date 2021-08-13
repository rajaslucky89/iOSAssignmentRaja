platform :ios, '11.0'

target 'Raja iOS Assignment' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Utilities
  pod 'RxSwift', '~> 6.0'
  pod 'RxCocoa', '~> 6.0'
  pod 'RxGesture', '~> 4.0.0'
  pod 'RxAlamofire', '~> 6.1'
  
  # User Interface
  pod 'Kingfisher', '~> 6.0'
  pod 'SkeletonView', '1.11.0'
  
  # Network debugging
  pod 'Wormholy', :configurations => ['Development', 'Sanity']

  target 'Raja iOS AssignmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Raja iOS AssignmentUITests' do
    # Pods for testing
  end

end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      if t.name == 'RxSwift'
        t.build_configurations.each do |config|
          if config.name == 'Debug' || config.name == 'Development' || config.name == 'Sanity'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
  end
end

