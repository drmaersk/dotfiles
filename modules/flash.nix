  flash = stdenv.mkDerivation rec {
    name = "flashplayer-ppapi-27.0.0.170";
    version = "27.0.0.170";
    
    src = fetchzip {
      url = "https://ftp.osuosl.org/pub/blfs/conglomeration/flashplayer/flash_player_ppapi_linux.x86_64.tar.gz";
      sha256 = "0d31c78f5e96488e548ce742d3acddf1fe05580a2a2bbc41032196a9f2c4c792";
      stripRoot = false;
    };
  };
  
