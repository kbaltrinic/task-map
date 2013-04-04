#! /bin/bash
ENV=$(uname -s)
case "$ENV" in
Darwin)
  CHROME_DRIVER="chromedriver_mac_26.0.1383.0.zip"
  ;;
Linux)
  CHROME_DRIVER="chromedriver_linux64_26.0.1383.0.zip"
  ;;
*)
  echo "Uknown environment: $ENV"
  exit 1
  ;;
esac
wget http://selenium.googlecode.com/files/selenium-server-standalone-2.31.0.jar
wget https://chromedriver.googlecode.com/files/$CHROME_DRIVER
unzip $CHROME_DRIVER
rm -f $CHROME_DRIVER
