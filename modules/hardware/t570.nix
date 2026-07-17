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

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      boot = {
        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
          luks.devices."luks-999f8f9b-fc1d-4ce3-a057-1882745503c2".device =
            "/dev/disk/by-uuid/999f8f9b-fc1d-4ce3-a057-1882745503c2";
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/luks-999f8f9b-fc1d-4ce3-a057-1882745503c2";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/18AE-5514";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
