set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)     # /MD (일반적 권장)
set(VCPKG_LIBRARY_LINKAGE dynamic) # DLL (런타임 DLL 배포)
set(VCPKG_BUILD_TYPE release)      # 릴리스만 빌드 (CI 속도↑)
