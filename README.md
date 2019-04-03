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

My first attempt at deployment made me really sad, but I was able to get it working after many different attempts.
1. Compiled the tarball in an alpine docker container 
2. Copied the tarball out of docker to my local machine
3. Copied the tarball from my local to the alpine linux server
4. Unzipped the tarball and ran it with commands 11 & 12 above
Note: Had to change the prox.exs config to url: [host: "hangman.servebeer.com", port: {:system, "PORT"}]
because web sockets do not work if the host does not match the users origin.

Supposedly for AWS/GCP there are specialized methods using those services in collaboration with an orchestrator
like Kubernetes that take advantage of the specialized infrastructure as code environments they offer,
which would be useful for more complex projects, outside of the scope of this readme.