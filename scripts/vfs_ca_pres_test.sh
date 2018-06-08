#!/bin/bash

### vfs_cache_pressure 적정 수치 확인용 스크립트
### 테스트 파일 사이즈 값 임의 수정해서 사용할것 (사이즈 커질수록 오래 걸림)
### echo 3 > /proc/sys/vm/drop_caches ### 캐시 비우기 (임시방편)
### echo 100 > /proc/sys/vm/vfs_cache_pressure  ### cache pressure 수치 조절
### syctl -w 로도 위 두 값 수정 가능

TEST_FILE_SIZE=512M
TEST_DIR=/usr/share
TEST_VALUES="100 90 80 70 60 50 40"
TEMP_DIR=${1:-$HOME}

echo 3 > /proc/sys/vm/drop_caches
dd if=/dev/zero of=$TEMP_DIR/testfile0 count=1 bs=$TEST_FILE_SIZE

i=1
for v in $TEST_VALUES;
do
	sysctl -w vm.vfs_cache_pressure=$v
	find $TEST_DIR> /dev/null
	cp $TEMP_DIR/testfile0 $TEMP_DIR/testfile$i
	echo '\n'
	echo '\n'
	echo "** vm.vfs_cache_pressure=$v **"
		time find $DIR/ > /dev/null
	((i++))
done

for ((v=0; v<$i; v++));
do
	rm -f $TEMP_DIR/testfile$v
done
