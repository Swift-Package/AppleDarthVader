#  WWDC25 - 采用 Swift 并发

```swift
@MainActor
class ImageModel {
	func fetchAndDisplayImage(url: URL) async throws {
		let (data, _) = try await URLSession.shared.data(from: url)
		let image = decodeImage(data, at: url)
		view.displayImage(image)
	}

	// 解码图像数据的耗时操作调度到后台线程
	@concurrent
	func decodeImage(data: Data, at url: URL) async -> Image {
		if let image = cachedImage[url] {// 但是从 MainActor 之外访问 MainActor 的缓存无法编译
			return image
		}
		// 解码出 Image存入缓存
		cachedImage[url] = Image
		return image
	}
}

// MARK: - 改进
@MainActor
class ImageModel {
	func fetchAndDisplayImageImproved(url: URL) async throws {
		if let image = cachedImage[url] {
			view.displayImage(image)
			return
		}
		
		let (data, _) = try await URLSession.shared.data(from: url)
		let image = await decodeImage(data)// 这里会隐式传递self
		cachedImage[url] = image
		view.displayImage(image)
	}

	@concurrent
	func decodeImage(data: Data) async -> Image {
		// 解码出 Image 存入缓存
		return image
	}
}
let image = await self.decodeImage(data)// 这里会隐式传递self

MainActor 会保护 ImageModel1 的 self 的可变状态
data 是值类型所以可 Sendable

nonisolated
class MyImage {
	var width: Int
	var height: Int
	var pixels: [Color]
	var url: URL
}

// MARK: - 接下来引入并发
func scaleAndDisplay(imageName: String) {
	let image = loadImage(imageName)// 主线程加载图片
	Task { @concurrent in
		image.scaleImage(by: 0.5)// 后台修改图片
	}
	view.displayImage(image)// 主线程显示图片
}

// MARK: - 上面的问题是后台线程正在修改图片数据,而主线程正在读取图片数据,这会导致数据竞争问题无法编译
func scaleAndDisplay(imageName: String) {
	// 将整个任务放到并发上下文中确保按顺序执行
	Task { @concurrent in
		let image = loadImage(imageName)
		image.scaleImage(by: 0.5)
		await view.displayImage(image)// 使用 await 切换回主线程
	}
}
// MARK: - 或者
@concurrent
func scaleAndDisplay(imageName: String) async {
	let image = loadImage(imageName)
	image.scaleImage(by: 0.5)
	await view.displayImage(image)// 使用 await 切换回主线程
}

// MARK: - 闭包传递的并发问题
func scaleAndDisplay(imageName: String) async throws {
	let image = loadImage(imageName)
	try await perform(afterDelay: 0.1) {
		image.scale(by: 0.5)
	}
	view.displayImage(image)
}

func perform(afterDelay delay: Double, body: () -> Void) async throws {
	try await Task.sleep(for: .seconds(delay))
	body()
}
```
