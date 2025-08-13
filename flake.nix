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

        copyparty.url = "github:9001/copyparty";
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

            homelab = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/homelab/configuration.nix
                    ./modules/nixos
                    inputs.home-manager.nixosModules.default
                ];
            };

            habib = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/habib/configuration.nix
                    ./modules/nixos
                    inputs.home-manager.nixosModules.default
                ];
            };
        };

        hm-modules.default = ./modules/hm;
    };
}
