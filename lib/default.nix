{inputs}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = {system}: let
    inherit (pkgs) vimUtils;
    inherit (vimUtils) buildVimPlugin;
    pkgs = legacyPackages.${system};
  in
    buildVimPlugin {
      name = "WLVS";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/LICENSE
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/justfile
        rm -rf $out/lib
      '';
      src = ../.;
    };

  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins;
    pkgs = legacyPackages.${system};
    WLVS-nvim = mkVimPlugin {inherit system;};
  in [
    # languages
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.vim-just
    vimPlugins.rust-tools-nvim

    # completion
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-buffer
    vimPlugins.cmp-path
    vimPlugins.cmp_luasnip

    # snippets
    vimPlugins.luasnip
    vimPlugins.friendly-snippets

    # telescope
    vimPlugins.plenary-nvim
    vimPlugins.popup-nvim
    vimPlugins.telescope-nvim
    vimPlugins.telescope-fzf-native-nvim

    # theme
    vimPlugins.kanagawa-nvim

    # floaterm
    # vimPlugins.vim-floaterm

    # toggleterm
    vimPlugins.toggleterm-nvim

    # git
    vimPlugins.neogit
    vimPlugins.gitsigns-nvim
    vimPlugins.diffview-nvim

    # extras
    vimPlugins.barbar-nvim
    vimPlugins.better-escape-nvim
    vimPlugins.dressing-nvim
    vimPlugins.fzf-lua
    vimPlugins.indent-blankline-nvim
    vimPlugins.lualine-nvim
    vimPlugins.mini-nvim
    vimPlugins.neoscroll-nvim
    vimPlugins.noice-nvim
    vimPlugins.nui-nvim
    vimPlugins.nvim-colorizer-lua
    vimPlugins.nvim-navic
    vimPlugins.nvim-notify
    vimPlugins.nvim-treesitter-context
    vimPlugins.nvim-ts-context-commentstring
    vimPlugins.nvim-web-devicons
    vimPlugins.rainbow-delimiters-nvim
    vimPlugins.todo-comments-nvim
    vimPlugins.treesj
    vimPlugins.trouble-nvim
    vimPlugins.which-key-nvim

    # configuration
    WLVS-nvim
  ];

  mkExtraPackages = {system}: let
    inherit (pkgs) nodePackages python3Packages;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    nodePackages.bash-language-server
    nodePackages.diagnostic-languageserver
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    pkgs.gopls
    pkgs.gotools
    pkgs.lua-language-server
    pkgs.nil
    pkgs.postgres-lsp
    pkgs.pyright
    pkgs.rust-analyzer

    # formatters
    pkgs.alejandra
    pkgs.gofumpt
    pkgs.golines
    pkgs.rustfmt
    python3Packages.black
  ];

  mkExtraConfig = ''
    lua << EOF
      require 'WLVS'.init()
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    extraPackages = mkExtraPackages {inherit system;};
    pkgs = legacyPackages.${system};
    start = mkNeovimPlugins {inherit system;};
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {inherit start;};
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  mkHomeManager = {system}: let
    extraConfig = mkExtraConfig;
    extraPackages = mkExtraPackages {inherit system;};
    plugins = mkNeovimPlugins {inherit system;};
  in {
    inherit extraConfig extraPackages plugins;
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
