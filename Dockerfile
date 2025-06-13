FROM gitea/runner-images:ubuntu-24.04
# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
        libwx-perl \
        2>/dev/null

# Set environment variable for version (to be overridden by docker-compose.yml)
ARG CHORDPRO_VERSION=6.050.7-2
ENV CHORDPRO_VERSION=${CHORDPRO_VERSION}

# Download and install chordpro package
RUN wget -O /tmp/package.deb "http://ports.ubuntu.com/pool/universe/c/chordpro/chordpro_${CHORDPRO_VERSION}_all.deb" && \
dpkg -i /tmp/package.deb || apt-get -f install -y && \
rm /tmp/package.deb

# delete lists to prohobit further installs
RUN rm -rf /var/lib/apt/lists/*
# Set entrypoint or CMD as needed
ENTRYPOINT tail -f /dev/null
