// swift-tools-version:5.6
import PackageDescription

let package = Package(
	name: "ReactiveDataSources",
	platforms: [
		.iOS(.v13)
	],
	products: [
		.library(
			name: "ReactiveDataSources",
			targets: ["ReactiveDataSources"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "7.1.1"),
		.package(url: "https://github.com/ReactiveCocoa/ReactiveCocoa", from: "12.0.0")
	],
	targets: [
		.target(
			name: "ReactiveDataSources",
			dependencies: [
				"ReactiveSwift",
				"ReactiveCocoa"
			]
		),
		.testTarget(
			name: "ReactiveDataSourcesTests",
			dependencies: ["ReactiveDataSources"]
		)
	]
)
