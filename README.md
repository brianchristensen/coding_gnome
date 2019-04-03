# coding_gnome
Repo for coursework from Elixir for Programmers by Dave Thomas aka The Coding Gnome

This was an excellent and enjoyable course!

Persistence and Deployment is not part of the course, unfortunately.

# Deployment
Creating a prod release on a local machine with Distillery from the Phoenix socket project:
1. Go into the phoenix project that we want to deploy
2. mix deps.get --only prod
3. MIX_ENV=prod mix compile
4. cd assets
5. npm run deploy
6. cd ..
7. mix release.init
8. MIX_ENV=prod mix release
9. test the prod release with: PORT=4001 _build/prod/rel/socket_gallows/bin/socket_gallows foreground
10. cp _build/prod/rel/socket_gallows/releases/0.1.0/socket_gallows.tar.gz {target}
11. cd into {target} and tar xvf socket_gallows.tar.gz
12. start the prod release with: PORT=80 ./bin/socket_gallows start 

To deploy to a remote machine, one need build the release in a Docker container 
which matches your target machine’s OS, kernel version, architecture, and system libraries,
for instance when developing on OSX and deploying on a Linux server.
1. Create a Dockerfile and a .dockerignore
2. In the same directory, build the image: docker build -t socket_gallows .

For AWS/GCP there are specialized methods using those services in collaboration with an orchestrator
like Kubernetes that take advantage of the specialized infrastructure as code environments they offer,
which would be useful for more complex projects, outside of the scope of this readme.