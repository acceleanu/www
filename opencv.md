# opencv 

[macos install](https://www.pyimagesearch.com/2018/08/17/install-opencv-4-on-macos/)

```
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 4.5.3 -b branch-4.5.3
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 4.5.3 -b branch-4.5.3
cd ..

mkdir build1
cd build1

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
    -D PYTHON3_LIBRARY=`python -c 'import subprocess ; import sys ; s = subprocess.check_output("python-config --configdir", shell=True).decode("utf-8").strip() ; (M, m) = sys.version_info[:2] ; print("{}/libpython{}.{}.dylib".format(s, M, m))'` \
    -D PYTHON3_INCLUDE_DIR=`python -c 'import distutils.sysconfig as s; print(s.get_python_inc())'` \
    -D PYTHON3_EXECUTABLE=$VIRTUAL_ENV/bin/python \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D BUILD_EXAMPLES=ON ../opencv
make -j4
sudo make install

cd /usr/local/lib/python3.9/site-packages/cv2/python-3.9
ln -s cv2.cpython-39-darwin.so cv2.so

cd $VIRTUAL_ENV
cd lib/python3.9/site-packages/
ln -s /usr/local/lib/python3.9/site-packages/cv2/python-3.9/cv2.so cv2.so
```

