{
    description = "nixos config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

		nvf.url = "github:notashelf/nvf";

        spicetify.url = "github:Gerg-L/spicetify-nix";
        ags.url = "github:aylur/ags";
    };

    outputs = { nixpkgs, nixpkgs-stable, ... } @ inputs: {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";

            specialArgs = {
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                };

                pkgs-stable = import nixpkgs-stable {
                    inherit system;
                    config.allowUnfree = true;
                };

                inherit inputs;
            };

            modules = [
                ./configuration.nix
                inputs.home-manager.nixosModules.default
            ];
        };
    };
}
