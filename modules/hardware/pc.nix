_: {
  flake.modules.nixos.hardware-pc =
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
            "ahci"
            "thunderbolt"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
          kernelModules = [ ];
          luks.devices."luks-c901bcac-a07e-4c6b-9be0-d0e24e0d19e6".device =
            "/dev/disk/by-uuid/c901bcac-a07e-4c6b-9be0-d0e24e0d19e6";
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/luks-c901bcac-a07e-4c6b-9be0-d0e24e0d19e6";
          fsType = "ext4";
        };
        "/mnt/games" = {
          device = "/dev/disk/by-uuid/4f96b204-be06-4ce4-8e4f-c38026f85da3";
          fsType = "ext4";
          # options = [
          #   "uid=1000"
          #   "nofail"
          # ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/12D8-E80A";
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
