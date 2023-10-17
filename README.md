# Octokid

**Web Application for Searching GitHub Repositories**

Website: [Octokid](https://octokid.stokwell.cloud)

## Project Overview

Octokid is a web application designed for searching GitHub repositories/ It provides users with a straightforward and user-friendly interface to explore GitHub's collection of repositories. 

## Choice of Technology Stack

In the process of developing Octokid, various key decisions were made to ensure the application's simplicity, efficiency, and effectiveness:

- **Sinatra Framework**: Instead of opting for a full-fledged framework like Rails, Sinatra was chosen due to its lightweight nature. Since the core functionality of Octokid does not necessitate database interactions, Sinatra was a suitable choice for building a minimalistic web application.

- **Octokit Gem**: Octokit, the official client for the GitHub API, was selected for repository searches. This gem provides comprehensive support for GitHub API features and maintains backward compatibility.

### Search Functionality and Limitations

- **GitHub Repository Search**: Octokid leverages the Octokit gem to perform repository searches. The gem facilitates paginated search results, making it suitable for handling extensive queries.

- **Result Limitation**: To address GitHub's result limitations, Octokid retrieves a maximum of 1000 results per search query. It also filters out empty repositories, enhancing user experience by displaying only relevant data.

- **Pagination**: A simple pagination system is implemented to allow users to navigate through search results, ensuring a comprehensive search experience.

## Testing Approach

### 1. Controller Testing

- **RSpec Framework**: RSpec is utilized as the primary testing framework for Ruby applications.

- **WebMock Library**: The WebMock library is employed to simulate HTTP request responses for API interactions.

#### Controller Testing Overview

The **Search Page Controller** handles user requests to search for GitHub repositories via the GitHub API. The testing methodology follows this structure:

1. **Request Stubbing**: WebMock is used to stub HTTP requests to the GitHub API, allowing for simulated responses.

2. **HTTP Request**: An HTTP GET request is sent to the `/search` endpoint, along with query and page parameters.

3. **Test Cases**: Two primary test cases are outlined in the code:

   a. *Positive Test Case*: This verifies the scenario where a valid query generates search results. It ensures that the response contains the expected repository link and that the API request has been correctly initiated.

   b. *Negative Test Case*: This evaluates the scenario where an empty query is submitted. The test checks if the response redirects to the index page and ensures that no API request is made.

### 2. End-to-End Testing

End-to-End Testing focuses on validating the user experience by testing the complete application flow. Specifically, it ensures that users can successfully search for GitHub repositories. The test procedure involves visiting the homepage, inputting a query, and clicking the "Search" button. The test includes two primary assertions to validate the URL and content of the results page.

## Running the Tests

You can run the tests using the following command:
```bash
rspec spec
