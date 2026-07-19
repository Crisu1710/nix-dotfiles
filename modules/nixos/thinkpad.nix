_: {
  flake.modules.nixos.thinkpad =
    { pkgs, ... }:
    {
      # Aktiviert den python-validity Hintergrunddienst für die Firmware
      services.python-validity.enable = true;

      # Aktiviert fprintd mit den Treibereinstellungen des Flakes
      services.fprintd.enable = true;

      # PAM-Authentifizierung für den Login und sudo aktivieren
      security.pam.services.login.fprintAuth = true;
      security.pam.services.sudo.fprintAuth = true;
    };
}
