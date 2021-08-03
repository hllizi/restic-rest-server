{pkgs ? import <nixpkgs> { system = "x86_64-linux"; } }:

with pkgs;
pkgs.dockerTools.streamLayeredImage {
  name = "rest-server";
  contents = pkgs.restic-rest-server;
  config = {
    Cmd = [ "${restic-rest-server}/bin/rest-server" "--path" "/backups" "--tls" "--tls-cert" "/ssl.crt" "--tls-key" "ssl.key" "--append-only" ];
    ExposedPorts = {
      "8000/tcp" = {};
    };
    Volumes = {
      "/backups" = {};
    };
  };
}
