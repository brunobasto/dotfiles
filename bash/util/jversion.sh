#!/bin/bash

tmpDir='/tmp/jversion_classes_dir'
jarTmpDir='/tmp/jversion_jar_dir'

mkdir -p $tmpDir && rm -f $tmpDir/*.class

if [[ "$1" == *.jar ]]
then
  unzip -d $jarTmpDir $1

  find $jarTmpDir -name "*.class" | while read FILENAME; do cp $FILENAME $tmpDir; done
else
  find $1 -name "*.class" | while read FILENAME; do cp $FILENAME $tmpDir; done
fi

cd $tmpDir

ls | while read FILENAME; do echo $FILENAME && javap -verbose ${FILENAME/".class"/""} | grep "major version"; done

rm -rf $tmpDir
rm -rf $jarTmpDir