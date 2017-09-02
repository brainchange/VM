@echo off
set os=ubuntu-1704
echo "[1] Ubuntu 17.04 [2] Ubuntu 16.04 [3] Ubuntu 14.04"
set /p id="Enter OS: "
set /p no="Number of Images: "
set /p name="Name of the Instances: "
IF %id%==1 set os=ubuntu-1704
IF %id%==2 set os=ubuntu-1604-lts
IF %id%==3 set os=ubuntu-1404-lts
set list=%name%-%no%
set /a no=%no%-1
:loop
set list=%list% %name%-%no%
set /a no=%no%-1
if "%no%" == "0" goto next
goto loop
:next
echo %list%
gcloud compute instances create %list% --image-family %os% --image-project=ubuntu-os-cloud --zone us-central1-a
