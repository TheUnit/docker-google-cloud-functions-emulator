# Docker: Google Cloud Function Emulator

This image is based on the [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker) base Ubuntu image and provides an environment for running Google Cloud Functions for the purposes of development and testing.

Available on [Docker Hub](https://hub.docker.com/r/theunit/google-cloud-functions-emulator/).

## Usage

### Where to Put Cloud Function Code

Cloud Functions should be placed in the `/root/functions` directory, where each subdirectory contains the code for a Google Cloud Function. The name of each subdirectory should exactly match the name of the Cloud Function's handler function.

##### Example Directory Structure

```
/root
    /functions
        /helloWorld
            - index.js
        /helloMoon
            - index.js
        /helloStars
            - index.js
```

#### Example File
`/root/functions/helloWorld/index.js`
```
exports.helloWorld = (req, res) => {
  //
};
```

### Running the Container

```bash
docker run -d --restart always \
    -v /path/to/first/function/helloWorld:/root/functions/helloWorld:rw \
    -v /path/to/second/function/helloMoon:/root/functions/helloMoon:rw \
    -p 8010:8010 \
    theunit/google-cloud-functions-emulator:1.0.0 /sbin/my_init
```

##### Docker Compose

```yaml
version: "2"
services:
    cloudfunctions:
        image: theunit/google-cloud-functions-emulator:1.0.0
        volumes:
            - /path/to/first/function/helloWorld:/root/functions/helloWorld
            - /path/to/second/function/helloMoon:/root/functions/helloMoon
        ports:
            - 8010:8010
```

Once the container is running you need to deploy the Cloud Functions before they'll work. You can do so by running:

```bash
docker exec {container_name} /root/deploy.sh
```

Once the Cloud Functions have been deployed a url for each function will be returned, which can be used for making requests to the function, e.g.:

```
http://localhost:8010/project/us-central1/helloWorld
```

If using `docker-machine` then replace `localhost` in the url with the IP of the Docker machine the container is running on.