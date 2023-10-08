# ACME USSD TEMPLATE 


This repository contains the source code and documentation for a USSD (Unstructured Supplementary Service Data) application built using Ruby, Sinatra, and PostgreSQL. The application follows a microservices architecture and utilizes Redis for caching purposes. 

# Introduction:

USSD (Unstructured Supplementary Service Data) is a communication protocol used by mobile phones to communicate with a service provider's servers. This project is an example of a USSD application that allows users to interact with various services via USSD codes. It is designed to be a microservices-based application, enabling easy scalability and maintenance. 


# Getting Started:

Prerequisites
Before you can run the USSD application locally or in a production environment, you will need to have the following prerequisites installed:

Ruby (>= 2.7.0)
Sinatra (>= 2.0.0)
PostgreSQL
Redis
Any additional dependencies specified in the project's Gemfile 

# Installation:
Clone the repository to your local machine: 
git clone https://github.com/yourusername/ussd-application.git
cd ussd-application 


Install the required Ruby gems using Bundler:
bundle install
 
Configure your PostgreSQL database and Redis cache by updating the configuration files or environment variables 

Run the migrations to create the necessary database tables:  
bundle exec rake db:migrate


# Start the Sinatra application:
bundle exec ruby app.rb 

The USSD application should now be running locally at http://localhost:4567.






