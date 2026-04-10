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
        dolphin-overlay.url = "github:rumboon/dolphin-overlay";

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
        };

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

            laptop = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/laptop/configuration.nix
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
