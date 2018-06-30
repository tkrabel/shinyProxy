## Shiny Proxy Set up (lokal)

### Schritt 1:

shiny proxy jar file herunterladen und in den gewünschten Projektordner schieben

### Schritt 2: 

Application.yml im selben Ordner erstellen und entsprechend konfigurieren

###Schritt 3: Mediator-Container für die Kommunikation zwischen ShinyProxy und Docker Daemon

ShinyProxy muss auf den Docker daemon zugreifen können. In Linux ist das möglich, bei Mac nicht. Deshalb muss ein Linux-Container dazwischen geschalten werden, der den Kommunikator zwischen ShinyProxy und Docker Daemon spielt. In Mac sollte folgendes getan werden:

```bash
# Starte den docker container, der auf Port 1234 lauscht und mit dem Docker Daemon für dich kommunizieren wird
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock

# Setze die Variable DOCKER_HOST neu
# Anstelle mit Docker Daemon (DOCKER_HOST) direkt zu kommunizieren (per default auf port 2357), wird nun auf den Post 1234 umgeleitet
export DOCKER_HOST=tcp://localhost:1234
```

Nun muss in der application.yml der port ebenfalls umgesetzt werden

```yaml
# Docker configuration
    docker:
      cert-path: /home/none
      url: http://localhost:1234
      port-range-start: 20000
```

