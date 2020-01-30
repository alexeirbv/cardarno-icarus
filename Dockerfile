FROM nixos/nix AS nixos-base
# Install depends
RUN nix-env -iA nixpkgs.git nixpkgs.curl

ADD ./assets/etc/nix/nix.conf /etc/nix/nix.conf

ENV GIT_COMMIT 36342f277bcb7f1902e677a02d1ce93e4cf224f0

WORKDIR /opt
RUN git clone https://github.com/input-output-hk/project-icarus-importer && \
    cd project-icarus-importer && git checkout ${GIT_COMMIT} && \
    nix-build . -A connectScripts.mainnetBlockchainImporter -o importer-bin
WORKDIR /opt/project-icarus-importer
CMD [ "/opt/project-icarus-importer/importer-bin" ]
