IMDB python micro api
=====================

Micro API to fetch IMDB movie rating.

#### Dependencies

- Docker 17.x or greater.

#### Usage

Expose at port 8080

`docker run -d -p 8080:80 npulidom/imdb-api`

#### API

```[GET] ./rating/<movieId>```

Content-Type: `text/html`

`movieId` : The IMDB movie ID without `tt` prefix.

##### Example

```[GET] ./rating/0072684```

Response: `8.1`

##### Curl

``` 
curl http://localhost:8080/rating/0072684
```
