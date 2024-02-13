# Deploying the API

This is a Python API developed using the FastAPI Framework

# Run the application using Docker

For Docker deploy, run the following commands inside the [api](../src/api/) folder:

````
docker build -t api:0.0.1 .
````
````
docker run -d --name apicontainer -p 80:80 api:0.0.1
````

You can access the application documentation using http://localhost/docs