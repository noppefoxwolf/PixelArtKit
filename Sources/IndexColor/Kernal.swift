import CoreImage

extension CIKernel {
    static func lookupTable() -> CIKernel {
        let url = Bundle.module.url(forResource: "Shaders", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        return try! CIKernel(functionName: "lookupTable", fromMetalLibraryData: data)
    }
}
