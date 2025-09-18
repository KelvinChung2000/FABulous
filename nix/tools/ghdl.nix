# Custom GHDL derivation with mcode backend from master branch
{ lib
, stdenv
, gnat
, zlib
, which
, pkg-config
 # Version control parameters (provided by default.nix)
 , owner ? "ghdl"
 , repo ? "ghdl"
 , rev
 , fetchSubmodules ? false
}:

stdenv.mkDerivation rec {
  pname = "ghdl-master";
  version = if rev == "master" then "5.0-dev" else rev;

  src = builtins.fetchGit {
    url = "https://github.com/${owner}/${repo}.git";
    rev = rev;
    # Note: builtins.fetchGit does not accept fetchSubmodules; if you need
    # submodules use a different fetcher or update this logic.
  };

  nativeBuildInputs = [
    pkg-config
    which
    gnat
  ];

  buildInputs = [
    zlib
  ];

  # GHDL uses a custom configure script, not autotools
  configureScript = "./configure";

  configureFlags = [
    "--enable-libghdl"
    "--enable-synth"
  ];

  enableParallelBuilding = true;

  # GHDL often needs this
  hardeningDisable = [ "format" ];

  # Set up environment variables for mcode backend
  preConfigure = ''
    chmod +x configure
    export PATH=${gnat}/bin:$PATH
  '';

  meta = with lib; {
    description = "GHDL - the open-source analyzer, compiler, and simulator for VHDL with mcode backend (master branch)";
    homepage = "https://github.com/ghdl/ghdl";
    license = licenses.gpl2Plus;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ ];
  };
}