# docker-easy-https

docker-compose.yml example
```
  easyhttps:
    image: easy-https
    ports:
    - "6452:443"
    volumes:
      - /etc/localtime:/etc/localtime:ro
    restart: always
    privileged: true
    environment:
    - UPSTREAM_SERVER=192.168.0.16:6052
```
