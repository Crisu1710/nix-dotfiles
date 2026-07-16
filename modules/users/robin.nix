_: {
  flake.modules.nixos.robin =
    { pkgs, ... }:

    {
      users.users.robin = {
        isNormalUser = true;
        description = "robin";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
          "render"
          "docker"
          "libvirtd"
        ];
        packages = with pkgs; [
          kdePackages.kate
        ];
      };
    };
}
