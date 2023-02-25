# Remote File-Server using Telegram API

> Team Members: 
>
> 1- Asem Abdelhady  (SD-01)
>
> 2- Mosab Mohamed  (SD-01)
>
> 3- Hadi Saleh (CS-01)
>
> 4- Jaffar Totanji (SD-01)



## Project Description: 

A telegram bot that accesses a remote server using telegram API.

It allows the system admin to navigate, retrieve and manipulate files of the remote server. Furthermore, it allows shell commands to be executed on the remote server through telegram messages. 

Moreover, it receives customized monitoring and logging messages from Grafana, and the notifications are pushed through the telegram bot to the user.

This is done by mounting your remote server's home directory in a running docker container for the telegram bot server with which you can use the telegram API.

## Goals:

- Grant a system admin access to their remote server through Telegram in situations where they don't have access to sufficient tools to work with their server. Eliminating the need for certain systems/dependencies to access the server.
- Notify the admin about critical events which may require their immediate attention, and the ability to handle such situations promptly and remotely.
- **Use Cases**:
  - The admin is away from their system, and are required to make a quick immediate change in the server, they can make that change immediately via any device with Telegram being the only dependency.
  - The admin is away from the system, a critical situation arises e.g. Server CPU overheated. The sys admin can then simply access and shut down the server through their phone for example.

## Tasks: 

- Discuss the project idea and its features.
- Sketch the design of and information flow, and the design for the infrastructure.
- Implement the basic app structure in python, using the pyrogram wrapper for telegram API. 
- Dockerize the application.
- Make docker-compose file to run Grafana, Prometheus and node export locally.
- Configure Grafana to add dashboards for Prometheus and node-export.
- Add alerts to send notifications to the telegram bot from Grafana.
- Make all this run under Ansible.
- Add Github action so that with every feature added to the telegram bot server it builds and deploys docker image into docker-hub.  

## Methodology:

We adopted the waterfall development method, due to the fact that the project was big in terms of requirements and research, and small in terms of implementation. 
We also opted to only work on the project whenever we were all available in the same time because of the nature of the project idea and that all project parts are dependent and should be done sequentially. 
So, we organized meetings whenever everyone was free, and conducted it in the following way: 

1) Free discussion of researched task.
2) Deliberations on implementation specifics. 
3) Implementation
4) Discussion of next task

During the time between meetings, the members are required to research the task that will be discussed and implemented in the next meeting.

## Development:

- **Design Specification**

  - 

- **Implementation**

  1) Used pyrogram to implement three main features (```cd, ls, get```)
  2) Implement Docker file that securely run the telegram bot server by mounting the home directory.
  3) Made Docker-compose file to handle monitoring
  4) Prometheus:
     - Made the Prometheus yaml file to get the system hardware performance metricies to monitor the system state. 
     - Added the Prometheus configurations to the docker-compose file
  5) Node Export:
     - Added node export configurations to the docker-compose file
  6) Grafana:
     - Added Grafana's configurations to the docker-compose file 
  7) Implement The ```run``` feature, which executes shell scripts on the remote server.
  8) Made the ```inventory.ini``` to be specific to run on the localhost
  9) Made the Ansible configuration file (```.cfg```)
  10) Ansible:
      - Made the Ansible ```main.yaml``` to run four tasks:
        1. Copy monitoring folder to ```/tmp``` in the development phase
        2. Copy app folder to ```/tmp``` in the development phase
        3. Run the docker-compose from ```/tmp/monitoring```
        4. Run the docker-compose from ```/tmp/app```

- **Testing **

  1. Clone the repository from another several other machines 
  2. Configured the ```.env``` file for each cloned repo
  3. Ran the ansible-playbook 
  4. Tested the Telegram bots' functionality  

- **CI/CD**

  - Made a github CI/CD file

  - Added one job to run two steps: 

    1. Builds the docker-image on each commit

    2. Deploys the docker-image on dockerhub 

       

## Development Logs:

### 16/11/2022: Project Idea

- Discussing and Finalizing project idea.
- Agreeing on development methodology.
- Sketched the infrastructure design.
- git init  

### 21/11/2022: Basic funcionality

- Deciding what features will be added.
- Adding basic features (```cd, ls, get```)

### 30/11/2022: Docker

- Made the app's docker file.

### 05/12/2022: Ansible, Logging, Monitering

- Made the docker-compose file for monitoring.
- Added the Prometheus, Node Export, and Grafana configurations to the docker-compose file.
- Made the first draft of the Ansible file. 

### 07/12/2022: Ansible, Run feature, Docker Compose 

- Added the ```run``` feature.
- Made the docker-compose for the app.
- Finish the Ansible to run both docker-compose files.

### 09/12/2022: Testing

- Tested the telegram bot in different environments 

### 11/12/2022: Github Actions

- Made the github actions CI/CD file.

### 12/12/2022: Demo, Readme, Report

- Made the demo showcasing the configurations and features.
- Wrote a comprehensive **README to explain how to setup the bot (Because it is extremely personalized)**.
- Reaching a conclusion and writing the report of the project.

### 13/12/2022: Finalization

- Final touches. 

## Difficulties:

Although we wanted to include unit tests in our project, we struggled to find proper features to test. due to the fact that the telegram bot is an always running process. And due to the nature of this project and its focus on system administration there weren't much focus on app features which led to little to no reasonable tests to add, so we opted to focus on other administrative areas instead because it was more logical in regards to this project.

We also faced some difficulties in how to make the docker container secure in terms of limiting the user's access to root files and in the same time preventing other unwanted users with different credentials from the ```.env``` file to use the personalized bot of a specific user. 

We solved this issue by making a function that checks the credentials of the user before responding to any command. Furthermore in the docker file we mounted the home to storage and changed the permissions so they are suitable for the container user. 

And finally we had some issues in making a json file suitable for the Grafana dashboard, So we used an existing template.

## Conclusion:

Throughout the development process, we got to know more about Prometheus and Node Export which are monitoring tool that are extremely powerful in terms of system hardware and performance metrices and logging and we learned the different areas it could be applied to and how useful it is.

Additionally, we learned more about Grafana and how helpful it is in system performance logs an metricies visualization. And how it could be used to produce customizable alerts.

Furthermore, we gained more experience in Docker and Docker-Compose which will be helpful in future projects, courses, and ultimately in the job market later on.

Moreover, the nature of this project made us more comfortable to work in a team and our adoption of the waterfall development method made us recognize the value of predetermining the requirements and design to have a concrete base to build on instead of making it up along the way. 

Finally, it is safe to say that this course and this project specifically helped us learn and use Monitoring tools, Logging and Logging rotation, Bash Scripting, Ansible, CI/CD, Docker, and Docker-Compose with a deep understanding. And helped us prepare for future challenges that will be extremely dependent on these concepts whether in the job market or the academic field.

## Links 

1- [Project repository](https://github.com/Asem-Abdelhady/Telegram_bot_to_access_remote_server)

2- [Demo video](https://youtu.be/KSmbT2lXGpg)



## Notes

- It is advisable to read the [README](https://github.com/Asem-Abdelhady/Telegram_bot_to_access_remote_server) to 
