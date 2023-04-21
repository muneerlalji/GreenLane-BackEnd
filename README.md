# GREENLANE!

Our product is a bike-sharing platform that enables cities to track bike usage and availability and
optimize bike-sharing operations for improved mobility and sustainability. Greenlane is not your average
bike-sharing program; it's a revolutionary initiative that addresses numerous pressing issues faced by
modern societies. By reducing congestion on roads, Greenlane makes commuting easier and more
efficient for everyone.

Instructions for running this repo: 

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

Once this is running, you can launch AppSmith and run our app through there!

Here's a link for a demo of our application working: 
https://drive.google.com/file/d/12v9DthO_o-7hJbtaKKLQG5_YGFBq1E0o/view



