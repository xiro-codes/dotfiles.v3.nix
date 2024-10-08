{
  mkShell,
  just,
  neovim,
  ranger,
  git,
  ...
}:
mkShell {
  packages = [just neovim ranger git];
  shellHook = ''
    just -l
  '';
}
