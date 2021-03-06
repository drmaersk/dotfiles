{ config, lib, pkgs, ... }:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    cntlm
  ];

  services.cntlm.domain = "mecel";
  services.cntlm.enable = true;
  services.cntlm.proxy = ["semegot-pr02.mecel.net:80"];
  services.cntlm.port = [3128];
  services.cntlm.username = "RoberthA";
  services.cntlm.password = "";
  # To generate new hash: cntlm -u RoberthA -d mecel -H semegot-pr02.mecel.net 80
#  NoProxy localhost, 127.0.0.*, 10.*, 192.168.*, *.delphiauto.net  
  services.cntlm.extraConfig = "
NoProxy *
Auth            NTLMv2
PassNTLMv2      8ACF7FF88932CD7089B8589D8B677E41
";
  networking.proxy.noProxy = "*";
  networking.proxy.default = "http://127.0.0.1:3128";

  environment.etc.gitconfig.text = ''
  [url "https://github.com/"]
    insteadOf = git://github.com/
	[url "https://github.com/openembedded/"]
    insteadOf = git://git.openembedded.org/
	[url "https://git.yoctoproject.org/git/"]
    insteadOf = git://git.yoctoproject.org/
	[url "https://git.kernel.org/"]
    insteadOf = git://git.kernel.org/
	[url "http://sourceware.org/git/"]
    insteadOf = git://sourceware.org/git/
	[url "http://code.qt.io/"]
    insteadOf = git://code.qt.io/
	[url "http://git.projects.genivi.org/"]
    insteadOf = git://git.projects.genivi.org/
	[url "http://anongit.freedesktop.org/git/"]
    insteadOf = git://anongit.freedesktop.org/
  '';
}
