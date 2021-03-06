# Recon

Reconnaisance for Recruitment.

## What is Recon?

Recon gamifies recruitment contributions. It assigns points for various Interview stages (such as Telephone, Pairing, etc), tracks Employee scores based on the interviews they take, and shows Leaderboards.

## Getting Started

The project is vagrantized. So all you need to do is:

* Install Vagrant
* Clone this repository
* Run `vagrant up` to provision and boot a VM
* Run `vagrant ssh` to login to the VM
* Run `cd /vagrant; rails server -b 0.0.0.0` to start the server
* Browse to `localhost:3000`
  * Click `Switch to Admin`
  * Login as `admin@example.com`/`password` (**NOTE**: seeded for development only)
  * Click `Organization > Employees > Upload Jigsaw CSV`
  * Upload a CSV file from Jigsaw (`jigsaw.thoughtworks.com > People > Export`)
  * Start creating Candidates!

## Release Policy

Recon is a rolling release with two branches:

* `dev `: Under active development, may contain breaking changes
* `release`: Current release-ready code, use this for deployments

## Deployment

**TL;DR - Always use the `release` branch for deployments.**

### Initial Setup

    # Install Docker
    curl -sSL https://get.docker.io | sh

    # Pull and run postgres (needs to be done only once)
    mkdir /var/lib/recon-postgres
    docker pull postgres:9
    docker run --name recon-postgres -v /var/lib/recon-postgres:/var/lib/postgresql/data -d postgres:9

    # Clone the repository
    git clone https://github.com/TWChennai/recon.git --branch release

### Build and Run

    # Make sure you're on the latest release branch
    git checkout release
    git pull

    # Build the latest Recon (this could take a while)
    docker build -t recon:latest .

    # Remove the old container (if you're redeploying)
    docker stop recon-prod
    docker rm recon-prod

    # Take a database backup (check do-backup.sh in the production machine)

    # Customize environment variables
    vi .env
    # Set at least SECRET_KEY_BASE=<some_value>

    # Run
    docker run --name recon-prod --link recon-postgres:postgres -p 80:3000 -e .env -d recon:latest

## Production Testing in Vagrant

    # Simply run:
    docker/start

    # Or install docker and follow the above instructions
