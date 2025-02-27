{
    description = "nixos config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim.url = "github:nix-community/nixvim";
        spicetify.url = "github:Gerg-L/spicetify-nix";
        ags.url = "github:aylur/ags";
    };

    outputs = { nixpkgs, ... } @ inputs: {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                inputs.home-manager.nixosModules.default
            ];
        };
    };
}
