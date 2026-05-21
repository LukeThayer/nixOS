{...}: {
  imports = [
    ./hardware/luke.nix
    ./user.nix
    ./home.nix
    ./wireless.nix
    ./gaming.nix
    ./cooler.nix
    ./ui.nix
    ./audio.nix
    ./hyprland.nix
  ];

  networking.firewall.allowedUDPPorts = [63436];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "luke";
}
