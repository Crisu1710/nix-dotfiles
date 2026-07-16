_: {
  flake.modules.nixos.hardware-t570 =
    {
      config,
      lib,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "thunderbolt"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
          kernelModules = [ ];
          luks.devices."luks-XXXXXXXXX".device =
            "/dev/disk/by-uuid/XXXXXXXX";
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/luks-XXXXXXXXX";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/A87A-4C74";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
