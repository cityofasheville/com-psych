#!/usr/bin/env bash

fme ComPsych_Munis_To_CSV.fmw

# Get env vars
set -a
source .env
set +a

echo $ftp_url
echo $ftp_pw
echo $ftp_user

date=$(date +%Y%m%d)
filename=compsych_CityofAsheville_TEST_$date.csv
echo $filename >> sftp.log

mv avl.sunlife_eligibility.csv $filename 

echo 'put' $filename > psftp.scr
echo '!echo "%date% %time%"' >> psftp.scr
echo 'close' >> psftp.scr

"C:\Program Files\PuTTY\psftp.exe" -P 22 -l $ftp_user -pw $ftp_pw $ftp_url -b ".\psftp.scr" >> sftp.log

mv $filename avl.sunlife_eligibility.csv