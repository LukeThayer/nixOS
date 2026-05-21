{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    coolercontrol.coolercontrol-gui
    liquidctl
  ];
  programs.coolercontrol.enable = true;
}
