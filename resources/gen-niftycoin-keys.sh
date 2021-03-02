#/bin/bash -e

DIR="niftycoin_keys"
PRIVATE_KEY="privkey.pem"
PUBLIC_KEY="pubkey.pem"
BITCOIN_PRIVATE_KEY="bitcoin_privkey"
BITCOIN_PUBLIC_KEY="bitcoin_pubkey"

if [ -d $DIR ]; then
        echo "Warning: $DIR already existing. Not generating any keys!"
        exit 1
fi
mkdir -p $DIR

# This generates the private key in the pem format that openssl uses.
echo "Generating private key"
openssl ecparam -genkey -name secp256k1 -rand /dev/urandom -out $DIR/$PRIVATE_KEY

# This generates the public key from the provided private key (which we just generated) and writes # it to a file in the pem format.
echo "Generating public key"
openssl ec -in $DIR/$PRIVATE_KEY -pubout -out $DIR/$PUBLIC_KEY

# This takes the private key in the pem format, converts it to the DER format, and extracts from 
# that format the 32 bytes for the private key and writes those as a hex string to a file.
echo "Generating BitCoin private key"
openssl ec -in $DIR/$PRIVATE_KEY -outform DER|tail -c +8|head -c 32|xxd -p -c 32 > $DIR/$BITCOIN_PRIVATE_KEY

# This takes the public key in the pem format, converts it to the DER format, and extracts from 
# that format the 65 bytes for the public key and writes those as a hex string to a file.
echo "Generating BitCoin public key"
openssl ec -in $DIR/$PRIVATE_KEY -pubout -outform DER|tail -c 65|xxd -p -c 65 > $DIR/$BITCOIN_PUBLIC_KEY
