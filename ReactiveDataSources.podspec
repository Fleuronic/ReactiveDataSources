Pod::Spec.new do |s|
  s.name             = "ReactiveDataSources"
  s.version          = "1.0.0"
  s.summary          = "This is a collection of reactive data sources for UITableView and UICollectionView."
  s.description      = <<-DESC
This is a collection of reactive data sources for UITableView and UICollectionView.

It enables creation of animated data sources for table an collection views in just a couple of lines of code.

                        DESC
  s.homepage         = "https://github.com/Omn1/ReactiveDataSources"                      
  s.license          = 'MIT'
  s.author           = { "Daniil Ostashev" => "daniil.ostashev@cruxlab.com" }
  s.source           = { :git => "https://github.com/Omn1/ReactiveDataSources.git", :tag => s.version.to_s }

  s.requires_arc          = true
  s.swift_version    = '5.0'

  s.source_files = 'Sources/RxDataSources/**/*.swift'
  s.dependency 'Differentiator', '~> 4.0'
  s.dependency 'ReactiveCocoa', '~> 10.0'

  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'

end
