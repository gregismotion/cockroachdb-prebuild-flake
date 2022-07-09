{
  description = "A scalable, survivable, strongly-consistent SQL database.";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
  }: {
    packages."x86_64-linux".default = nixpkgs.legacyPackages."x86_64-linux".callPackage ./cockroachdb.nix {};
  };
}

# github.com/thegergo02/cockroachdb-prebuild-flake
