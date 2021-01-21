DOMAIN=testadapter
DUMMYPASS=eksconnect
ALIAS=tomcat

.PHONY: create 

create:
	rm -f ${DOMAIN}.jks
	rm -f temp-PKCS-12.p12
    # create self signed cert and add it to a new java keystore
	openssl req -nodes -new -key testing.server.key -subj "/C=DE/ST=NRW/L=DUS/O=ITERGO/OU=ARTA2D/CN=${DOMAIN}" | \
		openssl x509 -req -sha256 -days 365 -signkey testing.server.key -out tempcrt.crt
	# bundle private key and cert via pkcs 12
	# https://www.wowza.com/docs/how-to-import-an-existing-ssl-certificate-and-private-key
	openssl pkcs12 -export -in tempcrt.crt -inkey testing.server.key -name ${ALIAS} -out temp-PKCS-12.p12 -password pass:${DUMMYPASS}
	keytool -importkeystore -srcstorepass ${DUMMYPASS} -deststorepass ${DUMMYPASS} -destkeystore ${DOMAIN}.jks -srckeystore temp-PKCS-12.p12 -srcstoretype PKCS12	

	# only bundle the cert for clients
	keytool -import -alias ${DOMAIN} -file tempcrt.crt -keystore ${DOMAIN}_pub.jks -storepass ${DUMMYPASS} -noprompt
