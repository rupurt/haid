{
  description = "haid - A hearing aid for agentic coding environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    keel.url = "path:../../spoke-sh/keel";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, keel }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rust = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "llvm-tools" ];
        };
        isLinux = pkgs.stdenv.isLinux;
        isDarwin = pkgs.stdenv.isDarwin;

        haid = pkgs.callPackage ./nix/haid.nix {
          rustPlatform = pkgs.makeRustPlatform {
            cargo = rust;
            rustc = rust;
          };
        };
      in {
        packages = {
          haid = haid;
          default = haid;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            rust
            pkgs.just
            pkgs.cargo-nextest
            pkgs.cargo-llvm-cov
            pkgs.pkg-config
            keel.packages.${system}.default
          ] ++ pkgs.lib.optionals isLinux [
            pkgs.mold
          ];

          shellHook = ''
            export CARGO_TARGET_DIR="$HOME/.cache/cargo-target/haid"
          '' + pkgs.lib.optionalString isDarwin ''
            export TMPDIR=/var/tmp
          '' + pkgs.lib.optionalString isLinux ''
            export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUSTFLAGS="-C link-arg=-fuse-ld=mold"
            export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_RUSTFLAGS="-C link-arg=-fuse-ld=mold"
          '';
        };
      });
}
