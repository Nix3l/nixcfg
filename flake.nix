{
    description = "nixcfg";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nvf.url = "github:notashelf/nvf";
        spicetify.url = "github:Gerg-L/spicetify-nix";
        polymc.url = "github:PolyMC/PolyMC";
    };

    outputs = { self, nixpkgs, ... } @ inputs: {
        nixosConfigurations = {
            pc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/pc/configuration.nix
                    ./modules/nixos
                    inputs.home-manager.nixosModules.default
                ];
            };
        };

        hm-modules.default = ./modules/hm;
    };
}
