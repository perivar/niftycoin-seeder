#!/bin/bash -e

# change the following variables to match your new coin
COIN_NAME="NiftyCoin"
COIN_UNIT="NFY"

COIN_URL="niftycoin.org"

# change
MAINNET_PORT="5333"

# keep
TESTNET_PORT="19335"
REGTESTNET_PORT="19444"
MAIN_RPC_PORT="9332";
TEST_RPC_PORT="19332";
REGTEST_RPC_PORT="19332";

COIN_NAME_LOWER=$(echo $COIN_NAME | tr '[:upper:]' '[:lower:]')
COIN_NAME_UPPER=$(echo $COIN_NAME | tr '[:lower:]' '[:upper:]')
COIN_UNIT_LOWER=$(echo $COIN_UNIT | tr '[:upper:]' '[:lower:]')

SED=sed

cd niftycoin-seeder

# first rename all directories
for i in $(find . -type d | grep -v "^./.git" | grep litecoin); do 
    git mv $i $(echo $i| sed "s/litecoin/$COIN_NAME_LOWER/")
done

# then rename all files
for i in $(find . -type f | grep -v "^./.git" | grep litecoin); do
    git mv $i $(echo $i| sed "s/litecoin/$COIN_NAME_LOWER/")
done

# now replace all litecoin references to the new coin name
for i in $(find . -type f | grep -v "^./.git"); do
    $SED -i "s/litecoin.org/$COIN_URL/g" $i
    $SED -i "s/Litecoin/$COIN_NAME/g" $i
    $SED -i "s/litecoin/$COIN_NAME_LOWER/g" $i
    $SED -i "s/LITECOIN/$COIN_NAME_UPPER/g" $i
    $SED -i "s/LTC/$COIN_UNIT/g" $i
done

# replace seeds in main.cpp
$SED -i "s/mainnet_seeds\[\] = {.*}/mainnet_seeds[] = {\"127.0.0.1\", \"\"}/" main.cpp
$SED -i "s/testnet_seeds\[\] = {.*}/testnet_seeds[] = {\"127.0.0.1\", \"\"}/" main.cpp

# replace height in db.h
$SED -i "s/return testnet ? 2000 : 1150000;/return testnet ? 100 : 500;/" db.h

# replace ports in protocol.h
#$SED -i "s/return testnet ? 19335 : 9333;/return testnet ? $TESTNET_PORT : $MAINNET_PORT;/" protocol.h

# replace ports $MAINNET_PORT
#$SED -i "s/9333/$MAINNET_PORT/" protocol.h

# replace all ports in one go
for i in $(find . -type f | grep -v "^./.git"); do
    $SED -i "s/\b9333\b/$MAINNET_PORT/g" $i
    $SED -i "s/\b19335\b/$TESTNET_PORT/g" $i
done

# replace messagestart bytes in main.cpp for testnet
$SED -i "s/pchMessageStart\[0\] = 0xfd;/pchMessageStart[0] = 0xfd;/" main.cpp
$SED -i "s/pchMessageStart\[1\] = 0xd2;/pchMessageStart[1] = 0xd2;/" main.cpp
$SED -i "s/pchMessageStart\[2\] = 0xc8;/pchMessageStart[2] = 0xc8;/" main.cpp
$SED -i "s/pchMessageStart\[3\] = 0xf1;/pchMessageStart[3] = 0xf1;/" main.cpp

# replace messagestart bytes in protocol.cpp for mainnet
$SED -i "s/pchMessageStart\[4\] = { 0xfb, 0xc0, 0xb6, 0xdb };/pchMessageStart[4] = { 0x4e, 0x49, 0x46, 0x54 };/" protocol.cpp
