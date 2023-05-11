# DO NOT MODIFY: Auto-generated by the gen_installer.py script from the .github/workflows/test.yml Github Action

export BUILD_TYPE='Release'
export SDL_VERSION='release-2.26.5'
export OPENCV_VERSION='4.7.0'
export CATCH_VERSION='v3.3.2'
export SPDLOG_VERSION='v1.11.0'
export EXIV2_VERSION='v0.28.0'
export GENERATOR='Ninja Multi-Config'

git submodule update --init
#sudo apt-get update
#sudo apt-get install -y libgtk-3-dev libopencv-dev libsdl2-dev libspdlog-dev


git clone https://github.com/catchorg/Catch2.git catch --depth 1 --branch $CATCH_VERSION
cd catch
cmake -B build -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DBUILD_TESTING=OFF
cmake --build build -j $(nproc) --target install
cd ..


git clone https://github.com/Exiv2/exiv2.git --depth 1 --branch $EXIV2_VERSION
cd exiv2
cmake -B build \
  -DCMAKE_INSTALL_PREFIX=install \
  `cat ../misc/build/exiv2-minimal-flags.txt`
cmake --build build --target install -j $(nproc)
cd ..

cmake -B build \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
  -DCMAKE_INSTALL_PREFIX=install \
  -DBUILD_TESTING=ON \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
  -DCatch2_DIR=../catch/install/lib/cmake/Catch2 \
  -Dexiv2_DIR=exiv2/install/lib/cmake/exiv2

cmake --build build -j $(nproc) --target install
cd build
ctest --output-on-failure
cd ..
