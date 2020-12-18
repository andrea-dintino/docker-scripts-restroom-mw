# Importing node14 docker image
FROM node:14

# Install nano for debug
RUN apt-get update
RUN apt-get install nano

# Installing restroom
RUN npx degit dyne/restroom-template restroom-mw

# setup docker
WORKDIR /restroom-mw
EXPOSE 3300 
EXPOSE 3301 

# Adding the .env file
RUN touch .env
RUN echo 'ZENCODE_DIR=/restroom-mw/zencode\n\
CUSTOM_404_MESSAGE=nothing to see here\n\
HTTP_PORT=3300\n\
HTTPS_PORT=3301\n'\
> /restroom-mw/.env

# Adding the exported files
RUN echo "Adding exported contracts from apiroom"
RUN echo "Scenario 'credential': issuer sign \nGiven that I am known as 'MadHatter' \nand I have my valid 'issuer keypair' \nand I have a 'credential request' inside 'Alice' \nWhen I create the credential signature \nThen print the 'credential signature' \nand print the 'verifier' \n"> ./zencode/credential-signining.zen
RUN echo '{"MadHatter":{"issuer_keypair":{"issuer_sign":{"x":"zK8Gs70vdLRErIKkTQdNbWfrWIExirgMKSxfGuPa1aU=","y":"x83wJ6rYhwowX/q4R0fNiE87JD4R48U1lBN21OgFJoE="},"verifier":{"alpha":"P/0EVN5KUGszzll5GlO9yI3p1p80BaWp5UdJ/R4rrRYyxcBg93F3KKOEYJtrsJ4SBlxbo59jeWEi2WBRnBwClNI4YOD3ak2llLNp7y6NN3FbSKF6ZI1aoeD22rp/SUTTQVfT6vMtzXDHaE8KEWBnN87Gb5unt6tDj1kVhbE9scTV5G62ZpJBBB3aUTbQsDtCGWQlBWb0jImIaJ3ZndChwzUVy2DBnRC5nqVDzH8BJ5AtPO46qwo8M4EQ7dLPCv1h","beta":"DxkhJCeC0LmNix2Q9XZxmHKwBv6fbYymNH6PGdvnOU6uD3NhZBbp+jA27kPon1CACigQ4IT/TpUGJwoy3M0o7l2x+mxPS6akE26kMrYARNC3fbYk6N9ugbjki8WX6uPQFheJJ1ZfSiiUQ02MFmIPTDKa0bRjXTyHak41+2SbQpPU1BYreIlIrDmzP8XrEaz0H0287Mg85L/iAXdtSpOk5qRyXm+lGa6QldyYkQ22xmNN6Ch0mIb3Ds9/e8EN1bM0"}}}}' > ./zencode/credential-signining.keys

# Debugging lines
RUN ls -al
RUN cat .env
RUN ls -al ./zencode
RUN cat .env

# yarn install and run
RUN yarn
CMD yarn start




 

