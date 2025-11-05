{
  description = "Nub's nixery";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-warez.url = "github:edolstra/nix-warez?dir=blender";
    nix-warez.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
#    hyprland.url = "github:hyprwm/Hyprland";
#    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    pipewire-screenaudio.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mkSystem = system: modules:
      nixosSystem {
        inherit system modules;
        specialArgs = {inherit inputs;};
      };
  in
    inputs.utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      # Packages
      packages = {
        nvim =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [{config = import ./nvim.nix;}];
          })
          .neovim;

        # Machine configurations
        nixosConfigurations = {
          zgamer = mkSystem system [
            ./zgamer.nix
          ];
          lgamer = mkSystem system [
            ./lgamer.nix
	  ];
 


          graybeard = mkSystem system [
            ./graybeard.nix
          ];
        };
      };
    });
}
