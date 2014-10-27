# Recon

Reconnaisance for Recruitment.

## Production

    # Pull and run postgres
    docker pull postgres:9
    docker run --name recon-postgres -v /var/lib/postgresql/data:/data/recon -d postgres:9

    # Build and run recon
    docker build -t recon:latest github.com/twchennai/recon
    docker run --name recon-prod --link recon-postgres:postgres -p 80:8080 -d recon:latest
