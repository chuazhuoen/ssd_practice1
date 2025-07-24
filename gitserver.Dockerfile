FROM node:alpine

# Install Git and tini, and install git-http-server globally
RUN apk add --no-cache tini git \
  && yarn global add git-http-server \
  && adduser -D -g git git

# Switch to the git user
USER git
WORKDIR /home/git

# Initialize a bare Git repository
RUN git init --bare repository.git

# ✅ Configure Git identity
RUN git config --global user.name "cze" && \
    git config --global user.email "chuaze2433@gmail.com"

# Start the Git HTTP server
ENTRYPOINT ["tini", "--", "git-http-server", "-p", "3000", "/home/git"]
