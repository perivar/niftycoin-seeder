#!/bin/bash -e

# change the following variables to match your new coin
COIN_NAME="NiftyCoin"
COIN_UNIT="NFY"
COIN_NAME_DENOM1="NiftyDollars"
COIN_NAME_DENOM2="NiftyCents"
COIN_NAME_DENOM3="Niftoshis"

COIN_URL="niftycoin.org"

# x million coins at total (litecoin total supply is 84000000)
TOTAL_SUPPLY=84000000

# change
MAINNET_PORT="5333"

# keep
TESTNET_PORT="19335"
REGTESTNET_PORT="19444"
MAIN_RPC_PORT="9332";
TEST_RPC_PORT="19332";
REGTEST_RPC_PORT="19332";

# Set these
PHRASE="BBC NEWS 21/Feb/2021 US plane scatters engine debris over Denver homes"
# First letter of the wallet address. Check https://en.bitcoin.it/wiki/Base58Check_encoding
PUBKEY_CHAR="53"
# number of blocks to wait to be able to spend coinbase UTXO's
COINBASE_MATURITY=100
# leave CHAIN empty for main network, -regtest for regression network and -testnet for test network
CHAIN=""
# this is the amount of coins to get as a reward of mining the block of height 1. if not set this will default to 50
#PREMINED_AMOUNT=10000

# warning: change this to your own pubkey to get the genesis block mining reward
GENESIS_REWARD_PUBKEY=044e0d4bc823e20e14d66396a64960c993585400c53f1e6decb273f249bfeba0e71f140ffa7316f2cdaaae574e7d72620538c3e7791ae9861dfe84dd2955fc85e8

# add this key information
MAIN_PUB_KEY=040184710fa689ad5023690c80f3a49c8f13f8d45b8c857fbcbc8bc4a8e4d3eb4b10f4d4604fa08dce601aaf0f470216fe1b51850b4acf21b179c45070ac7b03a9
MERKLE_HASH=ab4127c2db071267873ab33b6349d6c181a2aa79501848cba33c8c2460237a48
TIMESTAMP=1613933282
TIMESTAMP_TEST=1486949366
BITS=0x1e0ffff0

MAIN_NONCE=2085157839
TEST_NONCE=3581076
REGTEST_NONCE=0

MAIN_GENESIS_HASH=52a6b34f395c5e96052d53cca253c938625a33812a1aa2aeb7f17f89992efd62
TEST_GENESIS_HASH=38e91efebafe7fd0590085f4253a9d94d29729bc8022e1e5279a8e00adfa6b39
REGTEST_GENESIS_HASH=70e0c82bbb0b00624fe65880e6a9d5721b2964f5036e9c1216163ec237fccf15

POW_TARGET_TIMESPAN="3 * 24 * 60 * 60; // 3 days"
POW_TARGET_SPACING="2 * 60;"

# The message start string is designed to be unlikely to occur in normal data.
# The characters are rarely used upper ASCII, not valid as UTF-8, and produce
# a large 32-bit integer with any alignment.
MAIN_MESSAGE_START_BYTE0=0x4e
MAIN_MESSAGE_START_BYTE1=0x49
MAIN_MESSAGE_START_BYTE2=0x46
MAIN_MESSAGE_START_BYTE3=0x54

TEST_MESSAGE_START_BYTE0=0xfd
TEST_MESSAGE_START_BYTE1=0xd2
TEST_MESSAGE_START_BYTE2=0xc8
TEST_MESSAGE_START_BYTE3=0xf1

REGTEST_MESSAGE_START_BYTE0=0xfa
REGTEST_MESSAGE_START_BYTE1=0xbf
REGTEST_MESSAGE_START_BYTE2=0xb5
REGTEST_MESSAGE_START_BYTE3=0xda

MAIN_EXT_PUBLIC_KEY_BYTES="0x4E, 0x49, 0xB2, 0x1E"
MAIN_EXT_SECRET_KEY_BYTES="0x4E, 0x49, 0xAD, 0xE4"

# dont change the following variables unless you know what you are doing
LITECOIN_BRANCH=0.15
LITECOIN_REPOS=git@github.com:perivar/litecoin.git
LITECOIN_PUB_KEY=040184710fa689ad5023690c80f3a49c8f13f8d45b8c857fbcbc8bc4a8e4d3eb4b10f4d4604fa08dce601aaf0f470216fe1b51850b4acf21b179c45070ac7b03a9
LITECOIN_MERKLE_HASH=97ddfbbae6be97fd6cdf3e7ca13232a3afff2353e29badfab7f73011edd4ced9
LITECOIN_MAIN_GENESIS_HASH=12a765e31ffd4059bada1e25190f6e98c99d9714d334efa41a195a7e7e04bfe2
LITECOIN_TEST_GENESIS_HASH=4966625a4b2851d9fdee139e56211a0d88575f59ed816ff5e6a63deb4e3e29a0
LITECOIN_REGTEST_GENESIS_HASH=530827f38f93b43ed12af0b3ad25a288dc02ed74d6d7857862df51fc56c416f9
MINIMUM_CHAIN_WORK_MAIN=0x00000000000000000000000000000000000000000000002ebcfe2dd9eff82666
MINIMUM_CHAIN_WORK_TEST=0x0000000000000000000000000000000000000000000000000007d006a402163e

# Note! see also alot of hardcoded values for this branch in the replace statements

COIN_NAME_LOWER=$(echo $COIN_NAME | tr '[:upper:]' '[:lower:]')
COIN_NAME_UPPER=$(echo $COIN_NAME | tr '[:lower:]' '[:upper:]')
COIN_UNIT_LOWER=$(echo $COIN_UNIT | tr '[:upper:]' '[:lower:]')
COIN_NAME_DENOM1_LOWER=$(echo $COIN_NAME_DENOM1 | tr '[:upper:]' '[:lower:]')
COIN_NAME_DENOM2_LOWER=$(echo $COIN_NAME_DENOM2 | tr '[:upper:]' '[:lower:]')
COIN_NAME_DENOM3_LOWER=$(echo $COIN_NAME_DENOM3 | tr '[:upper:]' '[:lower:]')

SED=sed

git clone -b $LITECOIN_BRANCH $LITECOIN_REPOS litecoin

cd litecoin

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
    $SED -i "s/lites/$COIN_NAME_DENOM1_LOWER/g" $i
    $SED -i "s/Lites/$COIN_NAME_DENOM1/g" $i
    $SED -i "s/photons/$COIN_NAME_DENOM2_LOWER/g" $i
    $SED -i "s/Photons/$COIN_NAME_DENOM2/g" $i
    $SED -i "s/litoshis/$COIN_NAME_DENOM3_LOWER/g" $i
    $SED -i "s/Litoshis/$COIN_NAME_DENOM3/g" $i
done

# also fix .gitignore
$SED -i "s/Litecoin/$COIN_NAME/g" .gitignore
$SED -i "s/litecoin/$COIN_NAME_LOWER/g" .gitignore
$SED -i "s/LITECOIN/$COIN_NAME_UPPER/g" .gitignore

# now replace all ports
$SED -i "s/9333/$MAINNET_PORT/g" src/chainparams.cpp contrib/qos/tc.sh contrib/seeds/generate-seeds.py doc/tor.md src/rpc/net.cpp test/functional/proxy_test.py
$SED -i "s/19335/$TESTNET_PORT/g" src/chainparams.cpp contrib/qos/tc.sh contrib/seeds/generate-seeds.py doc/tor.md src/rpc/net.cpp test/functional/proxy_test.py

# set supply and maturity
$SED -i "s/84000000/$TOTAL_SUPPLY/" src/amount.h
$SED -i "s/COINBASE_MATURITY = 100/COINBASE_MATURITY = $COINBASE_MATURITY/" src/consensus/consensus.h

if [ -n "$PREMINED_AMOUNT" ]; then
   $SED -i "s/CAmount nSubsidy = 50 \* COIN;/if \(nHeight == 1\) return COIN \* $PREMINED_AMOUNT;\n    CAmount nSubsidy = 50 \* COIN;/" src/validation.cpp
fi

# set check for reg testnet to genesis (this must go first since sero will math what we set them to)
LITECOIN_REGTEST_CHECK_START=0
REGTEST_CHECK_REPL="\
\n            {\
\n                {  0, uint256S(\"0x${REGTEST_GENESIS_HASH}\")},\
\n            }\
\n        "
perl -0777 -p -i -w -e 's/(checkpointData = \(CCheckpointData\) \{)\s+\{\s+{\s*'"${LITECOIN_REGTEST_CHECK_START}"'.*?(?=\};)(\};)/$1'"${REGTEST_CHECK_REPL}"'$2/gs' src/chainparams.cpp

# set check for mainnet to genesis
LITECOIN_MAIN_CHECK_START=1500
MAIN_CHECK_REPL="\
\n            {\
\n                {  0, uint256S(\"0x${MAIN_GENESIS_HASH}\")},\
\n            }\
\n        "
perl -0777 -p -i -w -e 's/(checkpointData = \(CCheckpointData\) \{)\s+\{\s+{\s*'"${LITECOIN_MAIN_CHECK_START}"'.*?(?=\};)(\};)/$1'"${MAIN_CHECK_REPL}"'$2/gs' src/chainparams.cpp

# set check for testnet to genesis
LITECOIN_TEST_CHECK_START=2056
TEST_CHECK_REPL="\
\n            {\
\n                {  0, uint256S(\"0x${TEST_GENESIS_HASH}\")},\
\n            }\
\n        "
perl -0777 -p -i -w -e 's/(checkpointData = \(CCheckpointData\) \{)\s+\{\s+{\s*'"${LITECOIN_TEST_CHECK_START}"'.*?(?=\};)(\};)/$1'"${TEST_CHECK_REPL}"'$2/gs' src/chainparams.cpp

# set tx check for mainnet to genesis
# replace the numbers below 59, 15164006833 etc.
perl -0777 -p -i -w -e 's/(chainTxData = ChainTxData\{)\s+\/\/ Data as of block 59.*?(?=1516406833,)\d+,(.*?(?=19831879,))\d+,(.*?(?=0.06))\d+.\d+(.*?(?=\};)\};)/${1}\n            '"${TIMESTAMP}"',${2}0,${3}0.0${4}/gs' src/chainparams.cpp

# set tx check for testnet to genesis
# replace the numbers below a0, 1516406749 etc.
perl -0777 -p -i -w -e 's/(chainTxData = ChainTxData\{)\s+\/\/ Data as of block a0.*?(?=1516406749,)\d+,(.*?(?=794057,))\d+,(.*?(?=0.01))\d+.\d+(.*?(?=\};)\};)/${1}\n            '"${TIMESTAMP_TEST}"',${2}0,${3}0.0${4}/gs' src/chainparams.cpp

# replace messagestart bytes for mainnet
$SED -i "s/pchMessageStart\[0\] = 0xfb;/pchMessageStart[0] = $MAIN_MESSAGE_START_BYTE0;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[1\] = 0xc0;/pchMessageStart[1] = $MAIN_MESSAGE_START_BYTE1;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[2\] = 0xb6;/pchMessageStart[2] = $MAIN_MESSAGE_START_BYTE2;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[3\] = 0xdb;/pchMessageStart[3] = $MAIN_MESSAGE_START_BYTE3;/" src/chainparams.cpp

# replace messagestart bytes for testnet
$SED -i "s/pchMessageStart\[0\] = 0xfd;/pchMessageStart[0] = $TEST_MESSAGE_START_BYTE0;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[1\] = 0xd2;/pchMessageStart[1] = $TEST_MESSAGE_START_BYTE1;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[2\] = 0xc8;/pchMessageStart[2] = $TEST_MESSAGE_START_BYTE2;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[3\] = 0xf1;/pchMessageStart[3] = $TEST_MESSAGE_START_BYTE3;/" src/chainparams.cpp

# replace messagestart bytes for regtestnet
$SED -i "s/pchMessageStart\[0\] = 0xfa;/pchMessageStart[0] = $REGTEST_MESSAGE_START_BYTE0;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[1\] = 0xbf;/pchMessageStart[1] = $REGTEST_MESSAGE_START_BYTE1;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[2\] = 0xb5;/pchMessageStart[2] = $REGTEST_MESSAGE_START_BYTE2;/" src/chainparams.cpp
$SED -i "s/pchMessageStart\[3\] = 0xda;/pchMessageStart[3] = $REGTEST_MESSAGE_START_BYTE3;/" src/chainparams.cpp

$SED -i "s/1,48/1,$PUBKEY_CHAR/" src/chainparams.cpp
$SED -i "s/1,176/1,$PUBKEY_CHAR/" src/chainparams.cpp

$SED -i "s/base58Prefixes\[EXT_PUBLIC_KEY\] = {0x04, 0x88, 0xB2, 0x1E};/base58Prefixes\[EXT_PUBLIC_KEY\] = {$MAIN_EXT_PUBLIC_KEY_BYTES};/" src/chainparams.cpp
$SED -i "s/base58Prefixes\[EXT_SECRET_KEY\] = {0x04, 0x88, 0xAD, 0xE4};/base58Prefixes\[EXT_SECRET_KEY\] = {$MAIN_EXT_SECRET_KEY_BYTES};/" src/chainparams.cpp

$SED -i "s/1317972665/$TIMESTAMP/" src/chainparams.cpp
$SED -i "s;NY Times 05/Oct/2011 Steve Jobs, Apple’s Visionary, Dies at 56;$PHRASE;" src/chainparams.cpp

$SED -i "s/$LITECOIN_PUB_KEY/$MAIN_PUB_KEY/" src/chainparams.cpp
$SED -i "s/$LITECOIN_MERKLE_HASH/$MERKLE_HASH/" src/chainparams.cpp
$SED -i "s/$LITECOIN_MERKLE_HASH/$MERKLE_HASH/" src/qt/test/rpcnestedtests.cpp

$SED -i "0,/$LITECOIN_MAIN_GENESIS_HASH/s//$MAIN_GENESIS_HASH/" src/chainparams.cpp
$SED -i "0,/$LITECOIN_TEST_GENESIS_HASH/s//$TEST_GENESIS_HASH/" src/chainparams.cpp
$SED -i "0,/$LITECOIN_REGTEST_GENESIS_HASH/s//$REGTEST_GENESIS_HASH/" src/chainparams.cpp

$SED -i "0,/2084524493/s//$MAIN_NONCE/" src/chainparams.cpp
$SED -i "0,/293345/s//$TEST_NONCE/" src/chainparams.cpp
$SED -i "0,/1296688602, 0/s//1296688602, $REGTEST_NONCE/" src/chainparams.cpp
$SED -i "0,/0x1e0ffff0/s//$BITS/" src/chainparams.cpp

$SED -i "s,vSeeds.emplace_back,//vSeeds.emplace_back,g" src/chainparams.cpp

# reset minimum chain work to 0
$SED -i "s/$MINIMUM_CHAIN_WORK_MAIN/0x00/" src/chainparams.cpp
$SED -i "s/$MINIMUM_CHAIN_WORK_TEST/0x00/" src/chainparams.cpp

# change bip activation heights
# each new improvement (bip) is activated at a future block to give people time to update their software
# as we are creating a new chain, set these to genesis
# mainnet
# bip 16 (added in litecoin 0.16)
# $SED -i "s/BIP16Height = 218579/BIP16Height = 0/" src/chainparams.cpp
# bip 34
$SED -i "s/BIP34Height = 710000/BIP34Height = 0/" src/chainparams.cpp
$SED -i "s!fa09d204a83a768ed5a7c8d441fa62f2043abf420cff1226c7b4329aeb9d51cf\");!$MAIN_GENESIS_HASH\"); // main genesis hash!" src/chainparams.cpp
# bip 65
$SED -i -r "s,BIP65Height = 918684;.*$,BIP65Height = 0;," src/chainparams.cpp
# bip 66
$SED -i -r "s,BIP66Height = 811879;.*$,BIP66Height = 0;," src/chainparams.cpp

# testnet
# bip 16 (added in litecoin 0.16)
# $SED -i "s/BIP16Height = 76/BIP16Height = 0/" src/chainparams.cpp
# bip 34
$SED -i "s/BIP34Height = 76/BIP34Height = 0/" src/chainparams.cpp
$SED -i "s!8075c771ed8b495ffd943980a95f702ab34fce3c8c54e379548bda33cc8c0573\");!$TEST_GENESIS_HASH\"); // test genesis hash!" src/chainparams.cpp
# bip 65
$SED -i -r "s,BIP65Height = 76;.*$,BIP65Height = 0;," src/chainparams.cpp
# bip 66
$SED -i -r "s,BIP66Height = 76;.*$,BIP66Height = 0;," src/chainparams.cpp

# pow targets
$SED -i -r "s,nPowTargetTimespan = 3.5 \* 24 \* 60 \* 60;.*$,nPowTargetTimespan = $POW_TARGET_TIMESPAN,g" src/chainparams.cpp
$SED -i -r "s,nPowTargetSpacing = 2.5 \* 60;.*$,nPowTargetSpacing = $POW_TARGET_SPACING,g" src/chainparams.cpp

# defaultAssumeValid
#$SED -i -r "s,0x59c9b9d3fec105bdc716d84caa7579503d5b05b73618d0bf2d5fa639f780a011.*$,0x$MAIN_GENESIS_HASH\"); // main genesis hash," src/chainparams.cpp
#$SED -i -r "s,0xa0afbded94d4be233e191525dc2d467af5c7eab3143c852c3cd549831022aad6.*$,0x$TEST_GENESIS_HASH\"); // test genesis hash," src/chainparams.cpp
#ref blockchain by example - set to zero
$SED -i -r "s,0x59c9b9d3fec105bdc716d84caa7579503d5b05b73618d0bf2d5fa639f780a011.*$,0x00\");," src/chainparams.cpp
$SED -i -r "s,0xa0afbded94d4be233e191525dc2d467af5c7eab3143c852c3cd549831022aad6.*$,0x00\");," src/chainparams.cpp

# set consesus
# These values are supposed to state the time window during which deployment of a particular protocol change is allowed to happen. 
# For regtest that window is set to be from times 0 to 999999999999, so that you can do it whenever you want.
# Make sure these are enabled from day 1 (except regtest which we keep)
perl -0777 -p -i -w -e 's/(consensus.vDeployments\[Consensus::DEPLOYMENT_\w+\].nStartTime).*/$1 = 0;/g' src/chainparams.cpp
perl -0777 -p -i -w -e 's/(consensus.vDeployments\[Consensus::DEPLOYMENT_\w+\].nTimeout) = (?!999999999999ULL).*/$1 = '"${TIMESTAMP}"';/g' src/chainparams.cpp

# remove all entries in chainparamsseeds.h
perl -0777 -p -i -w -e 's/(static SeedSpec6 pnSeed6_\w+\[\] = \{).*?(?=\};)\};/$1};/gs' src/chainparamsseeds.h

