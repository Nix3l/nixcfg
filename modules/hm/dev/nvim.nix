{ lib, config, ... }:

let
    cfg = config.hm.mods.dev.nvim;
in
{
    options.hm.mods.dev.nvim = with lib; {
        enable = mkEnableOption "nvim";
        discord = mkEnableOption "discord presence";
    };

    config = lib.mkIf cfg.enable {
        programs.nvf = {
            enable = true;
            enableManpages = true;

            settings.vim = {
                viAlias = true;
                vimAlias = true;

                theme = {
                    enable = true;
                    name = "gruvbox";
                    style = "dark";
                };

                options = {
                    signcolumn = "yes";

                    tabstop = 4;
                    shiftwidth = 4;
                    softtabstop = 0;

                    mouse = "a";

                    wrap = false;
                };

                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;
                snippets.luasnip.enable = true;
                lsp.enable = true;

                languages = {
                    enableTreesitter = true;

                    clang = {
                        enable = true;
                        cHeader = true;
                    };

                    assembly.enable = true;
                    nix.enable = true;
                    ts.enable = true;
                    java.enable = true;
                    rust.enable = true;
                };

                visuals = {
                    nvim-scrollbar.enable = true;
                    nvim-web-devicons.enable = true;
                    nvim-cursorline.enable = true;
                    fidget-nvim.enable = true;
                    highlight-undo.enable = true;
                    indent-blankline.enable = true;
                };

                utility.oil-nvim.enable = true;

                presence.neocord.enable = cfg.discord;

                keymaps = [
                    {
                        key = "<esc>";
                        mode = "n";
                        silent = true;
                        action = ":noh<CR>";
                    }
                    {
                        key = "<leader>e";
                        mode = "n";
                        silent = true;
                        action = ":e .<CR>";
                    }
                ];

                autocmds = [
                    {
                        event = [ "BufEnter" "BufNewFile" "BufRead" ];
                        command = "setlocal filetype=glsl";
                        pattern = [ "*.comp" "*.vs" "*.fs" ];
                    }
                    {
                        event = [ "BufEnter" "BufNewFile" "BufRead" ];
                        command = "setlocal filetype=c";
                        pattern = [ "*.c" "*.h" ];
                    }
                ];
            };
        };
    };
}
