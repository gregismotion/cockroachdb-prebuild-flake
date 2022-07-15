self: {
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.cockroachdb22;
in {
  options.services.cockroachdb22 = {
    enable = mkEnableOption "CockroachDB";
    package = mkOption {
      type = types.package;
      default = self.packages.${pkgs.system}.default;
      description = "CockroachDB package to use.";
    };
    workingDirectory = mkOption {
      type = types.path;
      description = "Path where CockroachDB should store it's data.";
    };
    startScript = mkOption {
      type = types.str;
      description = "Script to start CockroachDB with.";
      default = ''
          ${cfg.package}/bin/cockroach start-single-node --insecure --http-addr :9090 --listen-addr=localhost --background
      '';
    }; 
  };

  config = mkIf cfg.enable {
    systemd.services.cockroachdb22 = {
      description = "Starts CockroachDB.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = cfg.startScript;
        WorkingDirectory = cfg.workingDirectory;
        Type = "simple";
      };
    };
  };
}
