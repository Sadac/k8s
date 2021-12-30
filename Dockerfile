# FROM the image node:12 
FROM node:12

# create a folder to store the source files
WORKDIR /app

# copy the package.json and the package-lock.json to the WORKDIR
COPY package*.json /app/
COPY ./ /app/

# once copied install the dependencies
RUN npm install

# define a PORT env variable
ENV PORT=8080

# expose the port 8080 in the container
EXPOSE 8080

# start the application in the container
CMD [ "npm", "start" ]