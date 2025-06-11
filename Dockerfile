# Use an official lightweight Python image as base
FROM gitea/runner-images:ubuntu-24.04
# Install required packages
RUN apt update && \
    apt install -y --no-install-recommends \
        ca-certificates \
        wget \
        libdata-printer-perl \
        libfile-homedir-perl \
        libfile-loadlines-perl \
        libimage-info-perl \
        liblatex-encode-perl \
        libobject-pad-perl \
        libpdf-api2-perl \
        libstring-interpolate-named-perl \
        libtemplate-perl \
        libtext-layout-perl \
        libwx-perl
        # nodejs \
        # npm \

# Set environment variable for version (to be overridden by docker-compose.yml)
ARG CHORDPRO_VERSION=6.050.7-2
ENV CHORDPRO_VERSION=${CHORDPRO_VERSION}

# Download and install the .deb package
# Replace the URL below with the actual URL, using $DEB_VERSION
RUN wget -O /tmp/package.deb "http://ports.ubuntu.com/pool/universe/c/chordpro/chordpro_${CHORDPRO_VERSION}_all.deb" && \
dpkg -i /tmp/package.deb || apt-get -f install -y && \
rm /tmp/package.deb

# # install node
# ARG NODE_VERSION=20
# ENV NODE_VERSION=${NODE_VERSION}

# RUN apt install -y --no-install-recommends \
#     curl \
#     unzip && \
#     curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir './fnm' && \
#     cp ./fnm/fnm /usr/bin && fnm install $NODE_VERSION

RUN rm -rf /var/lib/apt/lists/*
# Set entrypoint or CMD as needed
ENTRYPOINT tail -f /dev/null
