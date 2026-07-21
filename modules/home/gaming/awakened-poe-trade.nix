_:

{
  flake.modules.homeManager.gaming =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        rusty-path-of-building
        (awakened-poe-trade.overrideAttrs (_: {
          postFixup = ''
            makeWrapper ${lib.getExe electron_40} $out/bin/awakened-poe-trade \
              --set XDG_SESSION_TYPE x11 \
              --add-flags "--ozone-platform=x11" \
              --add-flags $out/share/awakened-poe-trade/resources/app.asar \
              --prefix LD_LIBRARY_PATH : "${
                lib.makeLibraryPath [
                  libxtst
                  libxt
                ]
              }"
          '';
        }))
      ];
    };
}
