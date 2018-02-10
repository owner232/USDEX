cd src
make clean -f makefile.unix

mkdir -p leveldb/build_detect_platform‏
chmod +x leveldb/build_detect_platform‏
mkdir obj
cd leveldb
chmod 755 *
cd ..

make -f makefile.unix

