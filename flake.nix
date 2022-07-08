{
  description = "A scalable, survivable, strongly-consistent SQL database.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { 
        system = "x86_64-linux"; 
        config = { allowUnfree = true; };
      };

      stdenv.mkDerivation rec {
        name = "cockroachdb-${version}";
        version = "22.1.0";

        src = pkgs.fetchurl {
                url = "https://binaries.cockroachdb.com/cockroach-v${version}.linux-amd64.tgz";
                sha256 = "sha256-1K7jUf7GSthlyYF64Zkn0kOaSDJSkbb1n2UNRqA2qR4=";
        };
        sourceRoot = ".";
        
        nativeBuildInputs = [
          autoPatchelfHook
        ];

        installPhase = ''
        install -m755 -D cockroach-v${version}.linux-amd64/cockroach $out/bin/cockroach
        '';

        meta = with lib; {
                homepage = "https://www.cockroachlabs.com";
                description = self.description;
                platforms = platforms.linux;
        };
      };
  };
}

# github.com/thegergo02/cockroachdb-prebuild-flake
