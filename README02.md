Build and publish Docker images with GitHub Actions

I have to start by admitting that when I started programming at university in 2008 I had no idea what continuous deployment was. The first releases of software then when I focused on programming for Android were completely manual. First compile with Android Studio, generate the APK and upload it to a business website where the testers downloaded and installed the latest testing version.
After running this sacred procedure dozens of times and beginning to notice that I was wasting too much time and energy on this process, I decided to automate this process a bit. With this intention, I wrote a set of Powershell scripts to make the job easier and faster, to be able to concentrate on what is really important, programming.
After a few years, an excellent friend introduced me to something that I fell in love with at first sight: AppVeyor. The fact that there was “someone” in charge of compiling my code, run the unit tests, and generate the artifacts automatically was too much to ask at the time to be true. I later met Travis, Jenkins and TeamCity, but the first impression is stuck in my memory.
Today the terms of continuous integration and continuous deployment are almost mandatory for every developer. Tools like those mentioned above, need at some point OAuth configuration, webhooks, or configure the credentials of the external code repository like GitHub, Bitbucket, GitLab, etc.
Shell script
If we were to run this process with a script, the first idea that would probably come up would be something like the following shell script.

First we clone the git repository on main branch
Move to the source code root folder
Build the Docker image with the path of Dockerfile
Create the tag for the image
Login on Docker Hub with the username and password
Push the image to Docker Hub
Let’s do it now in magically way with GitHub Actions.
GitHub Actions
In late 2019 GitHub announced the CI-CD support for free repositories. GitHub Actions allows us to automate the way we build, test and deploy our software on various operating systems such as macOS, Windows and Linux. Supporting more and more languages such as Node.js, Python, Java, PHP, Ruby, C / C ++, .NET, Android, and iOS.
For that reason I did not hesitate a minute to venture into using this feature in my Spring Boot learning project, in which a Docker image is built and pushed to Docker Hub. First we are going to think roughly what the steps to follow would be if we had to do this process manually. This would be the sequence of steps to execute:
Clone the repository source code
Build the Docker image based on the Dockerfile
Push the created image to Docker Hub repository
But we have some conditions on our flow. We are going to execute our process of build a new image in all commits and pull requests created in our repository, but we are only going to push the created image to Docker Hub when a new tag is created in the main branch.
We can configure our workflow to start when an event happens in our repository, it can be a commit, a pull request, an issue or the creation of a tag. The workflow can contain one or more jobs that can run sequentially or in parallel in their own virtual machine or inside its own container. Each of these jobs contains one or more steps that define an action to be executed. One of the main advantages of having the workflow process in the GitHub environment is that we have access to a lot of information related to the repository, event, references, etc, through the object github.

GitHub Actions workflow components. From GitHub Docs
We are going to create our workflow definition file docker-image.yaml inside the repository folder .github/workflows, with the following structure. Lets define four steps for the workflow, running on a Ubuntu virtual machine and is triggered for push and pull requests.

GitHub Actions workflow for Spring Boot project
We are taking for the practice the springboot-starterkit project. Spring Boot microservice project with the following multistage Dockerfile.

Workflow definition
In the practice, a YAML file is used to define the workflow as we can see below. The latest version of the workflow definition file can be downloaded here. Now, lets analyze the function of every component here.

The trigger event is for every pull request and commit on any branch, that is what means the wildcard * on branches section. Also, the workflow will be executed for the creation of any tag with the Semver versioning scheme.
on:
  push:
    branches:
      - '*'
    tags:
      - 'v[0-9]+.[0-9]+.[0-9]+'
  pull_request:
    branches:
      - '*'
Actions
Checkout action
Checks out the repository source code with ref/SHA commit that trigger the workflow as HEAD.
- name: Checkout
  uses: actions/checkout@v2
Metatada action
Allow to extract the metadata information of the events and reference. In this step we configure the tags and labels for Docker image build and push. The first two tags use the Semver notation, and setup the last tag only when the event is not a tag creation, using the SHA of the event as label.
- name: Docker metadata
  id: metadata
  uses: docker/metadata-action@v3
  with:
    images: ${{ env.IMG_NAME }}
    tags: |
      type=semver,pattern={{version}}
      type=semver,pattern={{major}}.{{minor}}
      type=raw,value={{sha}},enable=${{ github.ref_type != 'tag' }}
For example, this is the output for a new pushed commit.

Docker login action
Authenticate on Docker Hub registry using the DOCKER_USERNAME and DOCKER_PASSWORD secrets created on the repository.
- name: Log in to Docker Hub
  uses: docker/login-action@v1
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_PASSWORD }}
Lets see the output of this Action.

Docker build and push action
Build and push the Docker image with the labels and tags previously obtained on Docker metadata step.
- name: Build and push Docker image
  uses: docker/build-push-action@v2
  with:
    context: .
    push: ${{
      github.event.base_ref =='refs/heads/main' &&
      github.ref_type == 'tag' &&
      !startsWith(github.ref, 'refs/tags/v0.')
    }}
    tags: ${{ steps.metadata.outputs.tags }}
    labels: ${{ steps.metadata.outputs.labels }}
Note that the image will be pushed to Docker Hub only when the event base reference is the main branch and the reference type is a new pushed tag and only for public versions. That is the function of the boolean expression on push field.
Build and push Docker image step output
Build and push Docker image step output
In this step, the workflow is already configured with GitHub Action components that we can reuse again in other projects.
Conclusions
If you have your source code hosted on GitHub, it’s practically impossible to look to another continuous integration tool with as much potential as GitHub Actions. I have made it part of my work routine, I invite you to use it to get the most out of it.
References
GitHub Actions: Write Docker container actions
