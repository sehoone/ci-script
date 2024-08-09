#!/bin/bash

# deploy step
echo "** deploy start **"
# 1. 소스 배포
echo "** 1. deploy vite-project build file **"
cd /jenkins/workspace/vite-project
cp -r dist/* /web/root/spa

# 2. 삭제하지 않을 파일 목록 생성(기존파일을 제거하기 위해). 빌드할때 만든 filelist.txt를 사용
echo "** 2. make dont delete file list **"
cd /web/root/spa/assets
sed -e 's/^/\.\//' filelist.txt > dontdel.txt

# 3. 현재 최신버젼이 아닌파일 and 파일수정일이 180일이 지난 파일 삭제 및 빌드 파일 삭제
echo "** 3. delete vite-project pre build file **"
find . -type f -not -path './images/*' -mtime +180 -print | grep -Fxvf dontdel.txt | xargs -r -d'\n' rm
# 3-1. 빌드 파일 삭제
rm -rf /jenkins/workspace/vite-project/dist/*

echo "** deploy end **"