# Realtime-Swedish-Railway-API

## Development

```sh
# build the docker image
$ docker build --tag swedish-railway-api .

# run the docker image
$ docker run --rm -it --publish 3000:3000 --env-file env.list swedish-railway-api
```

## Environment Variables

* __TRAFIK_INFO_URL__

    A required argument that defines the URL of the TrafikInfo API. This should be the JSON format version.

* __TRAFIK_INFO_AUTH_KEY__

    A required argument that defines the unique authentication key for TrafikInfo API.
