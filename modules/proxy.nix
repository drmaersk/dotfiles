{ config, lib, pkgs, ... }:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    cntlm
  ];
  services.cntlm.domain = "mecel";
#  services.cntlm.domain = "EUROPE";
  services.cntlm.enable = true;
  services.cntlm.proxy = ["10.236.88.106:80"];
#  services.cntlm.proxy = ["autoproxy-emea.delphiauto.net:8080"];
  services.cntlm.port = [3128];
  services.cntlm.username = "RoberthA";
  #services.cntlm.username = "mj08y1";
  services.cntlm.password = "";
  # To generate new hash: cntlm -u mj08y1 -d EUROPE -H autoproxy-emea.delphiauto.net:8080 8080
  # To generate new hash: cntlm -u RoberthA -d MECEL -H semegot-pr02.mecel.net 80
#  
  services.cntlm.extraConfig = "
NoProxy localhost, 127.0.0.*, 10.*, 192.168.*, *.delphiauto.net  
Auth            NTLMv2
PassNTLMv2      B404E57448F2BFA7D0B44E6E62B76592
";
# Rdppdskks4444
#  PassNTLMv2      38495C2BC3DCCE372639E39E98F626D8    # Only for user 'mj08y1', domain 'EUROPE'
  networking.proxy.noProxy = "localhost, 127.0.0.*, 192.168.*, *.delphiauto.net";
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
