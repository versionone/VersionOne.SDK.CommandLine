#!/bin/sh
V1API=${5:-http://localhost/VersionOne.Web/rest-1.v1/Data}
V1USER=${6:-admin}
V1PASS=${7:-admin}
V1ASSET=$1
V1CMD=$2
V1ATTRIBUTE=$3
V1VALUE=$4

curl -X POST --basic -u $V1USER:$V1PASS $V1API/$V1ASSET --data "<Asset><Attribute name='$V1ATTRIBUTE' act='$V1CMD'>$V1VALUE</Attribute></Asset>"