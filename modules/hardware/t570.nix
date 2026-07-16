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

      # Bootloader.
      # Starts with systemd-boot to get a bootable system. To move to
      # Secure Boot with lanzaboote later, set `boot.lanzaboote.enable = true`,
      # `boot.loader.systemd-boot.enable = lib.mkForce false`, and enroll keys
      # via `sbctl create-keys` with firmware in Setup Mode.
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      boot = {
        initrd = {
          # TODO: replace with values from
          # `nixos-generate-config --show-hardware-config`
          availableKernelModules = [
            "xhci_pci"
            "ehci_pci"
            "ahci"
            "nvme"
            "usb_storage"
            "sd_mod"
            "rtsx_pci_sdmmc"
          ];
          kernelModules = [ ];
          # TODO: replace the UUID and mapper name with your LUKS device.
          luks.devices."luks-XXXXXXXX".device =
            "/dev/disk/by-uuid/XXXXXXXX";
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        # TODO: replace device/UUID values with your generated hardware config.
        "/" = {
          device = "/dev/mapper/luks-XXXXXXXX";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/XXXX-XXXX";
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
