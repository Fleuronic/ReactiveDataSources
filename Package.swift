// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "ReactiveDataSources",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "ReactiveDataSources",
			targets: ["ReactiveDataSources"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", branch: "swift-concurrency"),
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
