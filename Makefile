metallib:
	cd Sources/IndexColor && \
	xcrun -sdk iphoneos metal -fcikernel -c Shaders.metal -o Shaders.air && \
	xcrun -sdk iphoneos metallib -cikernel Shaders.air -o Shaders.metallib && \
	rm Shaders.air
