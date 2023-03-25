# kafka-test
Sorry for codestyle...

## Running Kafka in Cluster Mode

Run with docker compose:

```bash
CUR_IP=$(nmcli device show | grep IP4.ADDRESS | head -1 | awk '{print $2}' | rev | cut -c 4- | rev)
MY_IP=$CUR_IP docker-compose -f docker-compose-kafka.yml up -d
MY_IP=$CUR_IP docker-compose up -d
```

It will build and run the API and 2 Worker inside the docker.

Test:

```bash
curl "localhost:9091/api/v1/data" --include --request POST
```

HTTP answer:

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Date: Sat, 25 Mar 2023 08:23:08 GMT
Content-Length: 94

{"data":{"text":"Hello, here we go!"},"message":"success push data into kafka","success":true}
```

Worker2 log:

```
message at topic/partition/offset foo/0/0: {"text":"Hello, here we go!"}
```
