# Octokid

**Web Application for Searching GitHub Repositories**

Website: [Octokid](https://octokid.stokwell.cloud)

## Project Overview

Octokid is a web application designed for searching GitHub repositories. It provides the straightforward and user-friendly interface for users to explore GitHub's collection of repositories. 

- **Sinatra Framework**: Instead of opting for a full-fledged framework like Rails, Sinatra was chosen due to its lightweight nature. Since the core functionality of Octokid does not necessitate database interactions, Sinatra was a suitable choice for building a minimalistic web application.

- **Octokit Gem**: Octokit, the official client for the GitHub API, was selected for repository searches. This gem provides comprehensive support for GitHub API features and maintains backward compatibility.

- **GitHub Repository Search**: Octokid leverages the Octokit gem to perform repository searches. The gem facilitates paginated search results, making it suitable for handling extensive queries.

- **Result Limitation**: To address GitHub's result limitations, Octokid retrieves a maximum of 1000 results per search query. It also filters out empty repositories, enhancing user experience by displaying only relevant data.

- **Pagination**: A simple pagination is implemented to allow users to navigate through search results, ensuring a comprehensive search experience.

## Testing

- **RSpec Framework**: RSpec is utilized as the primary testing framework for Ruby applications.

- **WebMock Library**: The WebMock library is employed to simulate HTTP request responses for API interactions.

- **Cabybara**: Capybara tests web applications by simulating how a real user would interact with your app

The **Search Page Controller** handles user requests to search for GitHub repositories via the GitHub API. 

**Request Stubbing**: WebMock is used to stub HTTP requests to the GitHub API, allowing for simulated responses.

**HTTP Request**: An HTTP GET request is sent to the `/search` endpoint, along with query and page parameters.

**Test Cases**: Two primary test cases are outlined in the code:

   a. *Positive Test Case*: This verifies the scenario where a valid query generates search results. It ensures that the response contains the expected repository link and that the API request has been correctly initiated.

   b. *Negative Test Case*: This evaluates the scenario where an empty query is submitted. The test checks if the response redirects to the index page and ensures that no API request is made.

End-to-End Testing focuses on validating the user experience by testing the complete application flow. Specifically, it ensures that users can successfully search for GitHub repositories. The test procedure involves visiting the homepage, inputting a query, and clicking the "Search" button. The test includes two primary assertions to validate the URL and content of the results page.

You can run the tests using the following command:
```bash
rspec spec
```

# Continuous Integration & Deployment

## Overview

Continuous Integration (CI) and Continuous Deployment (CD) are crucial aspects of our development process. These practices help ensure the reliability and consistency of our software and streamline the deployment process. In this section, we'll outline the tools, workflows, and strategies we've adopted for CI/CD.

## GitHub Actions

### RSpec Workflow

Our CI/CD process begins with the RSpec workflow, triggered on every push to any branch. This workflow employs GitHub Actions to run our test suite using RSpec. This step helps us ensure the correctness of our codebase by running unit and integration tests.

### Docker Workflow

The Docker workflow is triggered on every push to the `master` and `deployment` branches. This workflow takes care of building a Docker image of our Octokit app, logging in to the Dockerhub repository, and pushing the built image. This enables us to maintain containerized versions of our application for deployment.

## Deployment Process

### Linode Instance

To deploy our Octokit app, we create a Linode Instance using Terraform. This cloud instance provides a scalable and reliable environment for running our application. Additionally, we add an SSH key to this instance, which is required for secure communication and management using Ansible.

### Ansible Playbooks

We utilize Ansible, an automation tool, to configure and provision our Linode server. Two Ansible playbooks are used:

1. The first playbook installs and configures Docker and Docker Compose on the server. This allows us to manage containerized applications easily.

2. The second playbook configures and starts Traefik, a reverse proxy and load balancer, and our Octokit app using `docker-compose` commands. Traefik plays a vital role in routing incoming requests and managing SSL certificates.

### SSL with Let's Encrypt

To secure our application and enable HTTPS on the host, we leverage Let's Encrypt, a trusted certificate authority. Let's Encrypt provides free SSL/TLS certificates, ensuring data encryption and secure communication between users and our application.

## Ongoing Improvements

Please note that our Continuous Integration & Deployment setup is an ongoing effort. We use it for demonstration and learning purposes, but it requires further refinements and considerations, especially regarding security:

- **User Permissions**: For enhanced security, we aim to create a dedicated user for Docker with limited privileges. This user should have permissions only to execute necessary Docker commands.

- **Private Docker Repository**: Storing Docker images in a private repository adds an extra layer of security. It limits access to our images and prevents unauthorized use.

By addressing these aspects and continuously improving our CI/CD process, we ensure a robust and secure deployment pipeline for our Octokit app.


