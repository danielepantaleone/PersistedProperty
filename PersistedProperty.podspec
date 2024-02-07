Pod::Spec.new do |s|
  s.name                        = "PersistedProperty"
  s.version                     = "1.1.0"
  s.summary                     = "A lightweight framework to persist iOS properties written in Swift"
  s.license                     = { :type => "MIT", :file => "LICENSE" }
  s.homepage                    = "https://github.com/danielepantaleone/PersistedProperty"
  s.authors                     = { "Daniele Pantaleone" => "danielepantaleone@me.com" }
  s.ios.deployment_target       = "11.0"
  s.osx.deployment_target       = "10.14"
  s.tvos.deployment_target      = "13.0"
  s.watchos.deployment_target   = "8.0"
  s.source                      = { :git => "https://github.com/danielepantaleone/PersistedProperty.git", :tag => "#{s.version}" }
  s.source_files                = "Sources/PersistedProperty/**/*.swift"
  s.resources                   = "Sources/PersistedProperty/**/*.xcprivacy"
  s.swift_version               = "5.7"
end
