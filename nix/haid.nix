{ lib, rustPlatform, pkg-config, zstd, git, ... }:

let
  cargoToml = lib.importTOML ../Cargo.toml;
in
rustPlatform.buildRustPackage {
  pname = "haid";
  version = cargoToml.package.version;

  src = ../.;

  cargoLock = {
    lockFile = ../Cargo.lock;
    outputHashes = {
      "candle-core-0.9.2" = "sha256-GeU7yc4vqN0hy3tJAq0LDhwnpO4XDeVVmxaBchKWkWg=";
      "candle-nn-0.9.2" = "sha256-GeU7yc4vqN0hy3tJAq0LDhwnpO4XDeVVmxaBchKWkWg=";
      "candle-transformers-0.9.2" = "sha256-GeU7yc4vqN0hy3tJAq0LDhwnpO4XDeVVmxaBchKWkWg=";
      "sift-0.2.0" = "sha256-WLOk8vK7johgJ1NMBKzeFeYHrMX//uvWG1er0Ztk5jw=";
    };
  };

  doCheck = false;

  nativeBuildInputs = [
    pkg-config
  ];

  nativeCheckInputs = [
    git
  ];

  buildInputs = [
    zstd
  ];

  meta = with lib; {
    description = "A hearing aid for agentic coding environments";
    homepage = "https://github.com/rupurt/haid";
    license = licenses.mit;
    maintainers = [ ];
  };
}
