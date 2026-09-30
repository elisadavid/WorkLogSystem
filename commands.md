Build the image:
docker build -t worklogsystem:latest .

Run it directly without Docker Compose:
docker run -d -p 8080:8080 --name worklogsystem worklogsystem:latest

If you want MySQL too:
docker compose up --build

For this project, the recommended command is:
docker compose up --build