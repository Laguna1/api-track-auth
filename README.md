![](https://img.shields.io/badge/Microverse-blueviolet)

## Api-track-auth
This is a REST API for managing database resources, in this case there are 3 tables in the database - this project has Users, Activities(their actions,  like sports trainings) and Trainings (monitored parameters, such as date, duration, distance, pulse, rate, etc.) ).
To create, view and edit activities and their tracked parameters of this User, "password_digest" and "auth_token" are used.
This rails api deployed on Heroku and assign to work with the react mobile app, where will bee the user interface.

![POST User new](./POST-new-user.png)
- 
- `curl --location --request POST 'http://localhost:3000/signup' \
--data-raw '{
    "name": "Oksana-auth",
    "email": "oksanaauth@mail.com",
    "password": "111111"
}'`

![POST User log in](./POST-user-log-in.png)
- 
- `curl --location --request POST 'localhost:3000/auth/login?email=oksanaauth@mail.com&password=111111' \
--data-raw '{
    "email": "oksanaauth@mail.com",
    "password": "111111"
}'`

### 'api-track-auth' API documentation
I have added a new documentary for the API as the nice-to-have feature for my Final Capstone project.
This documentation is available here:  
[Publish Documentation / POSTMAN](https://documenter.getpostman.com/view/13821409/TzY4eEN6)

### Live Demo

[Live Demo]() it only accessible for the [app-front](https://app-front.netlify.app/) Frontend

- ![User info JSON](./assets/images/user.png)
- ![Activity info JSON](./assets/images/activities.png)
- ![Tracking info JSON](./assets/images/track.png)


### Prerequisites

- Ruby v2.7.2
- Ruby on Rails v6.1.3.1
- Postgres: >=9.5
- Rspec
- Heroku

### Getting Started

To get a local copy up and running follow these simple example steps.
- `git clone https://github.com/Laguna1/api-track-auth/tree/development`
- `cd api-back`

### Setup

Instal gems with:

- `bundle install`

Setup database with:
 - `rails db:create`
 - `rails db:migrate`

### Usage

Start server with:

- `rails s`

Open `http://localhost:3000/` in your browser.

### Run tests

- `rspec`




### Author

👤 **Oksana Petrova**

- GitHub: [@github/Laguna1](https://github.com/Laguna1)
- Linkedin: [linkedin/OksanaPetrova](https://www.linkedin.com/in/oksana-petrova/)
- Twitter: [@OksanaP48303303](https://twitter.com/OksanaP48303303)

### 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Laguna1/api-track-auth/issues)

### Show your support

Give a ⭐️ if you like this project!

### Acknowledgments

You can access all the design info - color, typography, layouts - at this link:

### 📝 License
This project is [MIT](https://github.com/Laguna1/api-track-auth/LICENSE) licensed.


http :3000/auth/login \
> Authorization:'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2MjI4MTg0MjF9.MlwVCekTkBa0nqMPK6ZuTarjsX0F4q5q_GeRTLbKcss'