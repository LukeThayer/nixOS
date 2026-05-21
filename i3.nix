{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    dpi = 138;
    #    config = lib.mkAfter (builtins.readFile ./dotfiles/xorg.conf);
    xkb.layout = "us";
    xkb.variant = "";
    desktopManager.xterm.enable = true;
    windowManager.i3 = {
      package = pkgs.i3-rounded;
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3lock
        rofi
        dmenu
        polybar
      ];
    };
  };

  environment.variables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.displayManager = {
    defaultSession = "none+i3";
    # Enable automatic login for the user.
    autoLogin.enable = true;
    autoLogin.user = "luke";
  };

}
