#!/bin/bash
#
# Set system metrics constraints: Max Load Average, Min free RAM (MB)
MAX_LA=5.0
MIN_FR=250
alert_recip='akuchinsky@gmail.com'

alertmsg=''
la=$(uptime  |sed -e 's/.*average:\(.*\)/\1/'|awk -F, '{ print $1 }')
fr=$(free -tm |tail -1 |awk '{ print $4 }')

if [[ $la > $MAX_LA ]]
then
	alertmsg="Load Average critical! $la"
elif [[ $fr < $MIN_FR ]]
then
	alertmsg="Free RAM critical! $fr MB"
fi

if [ "$alertmsg" != '' ]
then
	echo $alertmsg |mail -s "System Metrics ALERT from $(hostname)" $alert_recip
else
	exit 
fi
