URL="http://localhost/spotweb/api?t=c"
TMPFILE=`mktemp /tmp/spotweb.XXXXXX`
curl -s -o ${TMPFILE} ${URL} 2>/dev/null
if [ "$?" -ne "0" ];
then
  echo "Unable to connect to ${URL}"
  exit 2
fi
RES=`grep -i "Spotweb API Index" ${TMPFILE}`
if [ "$?" -ne "0" ];
then
  echo "String Spotweb API Index not found in ${URL}"
else
  echo "String found"
fi
