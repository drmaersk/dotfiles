{ pkgs }:

let

opengrok = pkgs.opengrok.overrideAttrs (oldAttrs: rec {
  installPhase =
    ''
      mkdir -p $out
      cp -a * $out/
      substituteInPlace $out/bin/OpenGrok --replace /bin/uname ${coreutils}/bin/uname
      wrapProgram $out/bin/OpenGrok \
        --prefix PATH : "${stdenv.lib.makeBinPath [ ctags git ]}" \
        --set JAVA_HOME "${jre}" \
        --set OPENGROK_TOMCAT_BASE "/home/robban/tomcat"
    '';
});


