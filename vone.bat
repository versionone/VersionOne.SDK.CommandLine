SET V1API=http://localhost/VersionOne.Web/rest-1.v1/Data
SET V1USER=admin
SET V1PASS=admin
SET V1ASSET=%1
SET V1CMD=%2
SET V1ATTRIBUTE=%3
SET V1VALUE=%4

IF NOT [%5]==[] SET V1API=%5
IF NOT [%6]==[] SET V1USER=%6
IF NOT [%7]==[] SET V1PASS=%7

curl -X POST --basic -u %V1USER%:%V1PASS% %V1API%/%V1ASSET% --data "<Asset><Attribute name='%V1ATTRIBUTE%' act='%V1CMD%'>%V1VALUE%</Attribute></Asset>"