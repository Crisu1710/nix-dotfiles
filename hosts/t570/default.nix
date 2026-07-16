{ inputs, ... }:

{
  flake.nixosConfigurations.t570 = inputs.self.lib.mkNixos {
    hostname = "t570";
    system = "x86_64-linux";
    modules = [
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.self.modules.nixos.kernel
      inputs.self.modules.nixos.hardware-t570
      inputs.self.modules.nixos.binfmt
      inputs.self.modules.nixos.locale
      inputs.self.modules.nixos.robin
      inputs.self.modules.nixos.gaming
      inputs.self.modules.nixos.desktop
      inputs.self.modules.nixos.vpn
      inputs.self.modules.nixos.veracrypt
      inputs.self.modules.nixos.flatpak
      inputs.self.modules.nixos.sshfs
      inputs.self.modules.nixos.networking
      { home-manager.users.robin = ./home.nix; }
    ];
  };
}
