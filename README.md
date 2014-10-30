# Recon

Reconnaisance for Recruitment.

## Production

    # Pull and run postgres (needs to be done only once)
    mkdir /var/lib/recon-postgres
    docker pull postgres:9
    docker run --name recon-postgres -v /var/lib/recon-postgres:/var/lib/postgresql/data -d postgres:9

    # Build Recon (this is going to take quite a bit of time)
    docker build -t recon:latest github.com/twchennai/recon

    # Run Recon
    docker run --name recon-prod --link recon-postgres:postgres -p 80:8080 -d recon:latest

    # Redeploy
      # first build
      docker stop recon-prod
      docker rm recon-prod
      # and then run
