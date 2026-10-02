# Docker-Web-Redirect #

This Docker container listens on port 80 and redirects all web traffic to the given target domain/URL.

## Features ##
- Lightweight: Uses only ~2 MB RAM on Linux
- Keeps the URL path and GET parameters
- Permanent or temporary redirect

## Usage ##
### Docker run ###
The target domain/URL is set by the `REDIRECT_TARGET` environment variable.  
Possible redirect targets include domains (`mydomain.net`), paths (`mydomain.net/my_page`) or specific protocols (`https://mydomain.net/my_page`).  

**Example:** `$ docker run --rm -d -e REDIRECT_TARGET=mydomain.net -p 80:80 morbz/docker-web-redirect`

### Permanent redirects ###
Redirects are, by default, permanent (HTTP status code 301). That means browsers will cache the redirect and will go directly to the new site on further requests. Also search engines will recognize the new domain and change their URLs. To make redirects temporary (HTTP status code 302), e.g. for site maintenance, set the environment variable `REDIRECT_TYPE` to `redirect`.

## Docker Compose ##
A sample docker-compose file that redirects to `mydomain.net` could look like this:

```yaml
services:
  redirect:
    image: https://github.com/FachschaftMathPhysInfo/sitzung-redirect.git#latest
    restart: unless-stopped
    environment:
      - REDIRECT_TARGET=mydomain.net
```
