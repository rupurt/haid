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
