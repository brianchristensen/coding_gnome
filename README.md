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

In order to simplify this I'm choosing to deploy my OTP app inside a docker container.
The deployment steps above are codified in the Dockerfile in the root directory.
It is a two stage build with the second stage taking the tarball generated in the
first stage and running it in a clean alpine container so that the size of the container
is only 10mb larger than the size of the OTP app alone.  It has overridable HOST and PORT:
docker run -d -e "HOST=hangman.servebeer.com" -e "PORT=18900" -p 3001:18900 socket_gallows