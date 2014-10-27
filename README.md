# Recon

Reconnaisance for Recruitment.

## Production

    # Build recon
    docker build -t recon .

    # Run postgres
    docker run --name recon-postgres -v /var/lib/postgresql/data:/data/recon -d postgres:9

    # Run recon
    docker run --name recon-prod --link recon-postgres:postgres -p 80:8080 -d recon
