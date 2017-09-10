@echo off
if "%1" == "-help" goto helpp
if not "%1" == "-help" goto startt
:helpp
echo ==================================HELP================================
echo startup_script.bat [os] [number of instances] [name of instances] [user] [password] [server] [browser] [Starting Website] [username] [password]
echo WARNING!!        All the Arguments Must Be Present!!
echo os       -         1 (Ubuntu 17.04) or 2 (Ubuntu 16.04) or 3 (Ubuntu 14.04)
echo number   -         enter the number of instances u want to create
echo name     -         enter the name of the instance(s)
echo user     -         1 (root) or Any other Username
echo password -         1 (akshay@123) or Any other password
echo server   -         1 (xrdp) or 2 (vnc)
echo browser  -         1 (chrome) or 2 (firefox) or 3 (chromium)
echo website  -         enter the website url
echo ======================================================================
echo example  -
echo ubuntu1604 5-instances name-test GCP Chrome - 
echo startup_script.bat 2 5 test 1 1 1 1 www.facebook.com kaustav kaustav123232
goto end
:startt
set os=ubuntu-1704
set  id="%1"
set  no="%2"
set  name="%3"
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
gcloud compute instances create %list% --image-family %os% --image-project=ubuntu-os-cloud --zone us-central1-a --metadata startup_scrip="curl -o main.sh https://raw.githubusercontent.com/brainchange/VM/master/main.sh;sed -i 's/\r//' main.sh; sed -i 's/www.google.com/%8/' main.sh;sed -i 's/username123/%9/' main.sh;sed -i 's/password123/%10/' main.sh;sudo bash main.sh %4 %5 %6 %7 1;"
:end
echo =======================================================================