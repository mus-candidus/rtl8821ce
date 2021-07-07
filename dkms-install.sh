#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-install.sh\"" 2>&1
  exit 1
else
  echo "About to run dkms install steps..."
fi

RELEASE_ID=$(lsb_release -i -s)
RELEASE_VER=$(lsb_release -r -s)

if [[ "$RELEASE_ID" == "openSUSE" && "$RELEASE_VER" == "15.3" ]]; then
  echo "Found openSUSE 15.3"
  export BUILDFLAGS="-DOPENSUSE_15_3"
fi

DRV_NAME=rtl8821ce
DRV_VERSION=v5.5.2_34066.20200325

cp -r . /usr/src/${DRV_NAME}-${DRV_VERSION}

dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
RESULT=$?

echo "Finished running dkms install steps."

exit $RESULT
