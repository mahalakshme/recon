# Recon

Reconnaisance for Recruitment.

## Production

    # Pull and run postgres
    mkdir /var/lib/recon-postgres
    docker pull postgres:9
    docker run --name recon-postgres -v /var/lib/recon-postgres:/var/lib/postgresql/data -d postgres:9

    # Build and run recon
    docker build -t recon:latest github.com/twchennai/recon
    docker run --name recon-prod --link recon-postgres:postgres -p 80:8080 -d recon:latest
