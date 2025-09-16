# NextPNR - Place and route tool
{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, python3
, boost
, eigen
, icestorm
, trellis
, python3Packages
, owner
, repo
, rev
, hash
, fetchSubmodules ? true
}:

stdenv.mkDerivation rec {
  pname = "nextpnr";
  version = if (lib.hasPrefix "nextpnr-" rev) then lib.removePrefix "nextpnr-" rev
           else if (lib.hasPrefix "v" rev) then lib.removePrefix "v" rev
           else "dev-${lib.substring 0 7 rev}";

  src = fetchFromGitHub {
    inherit owner repo rev hash fetchSubmodules;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    python3
  ];

  buildInputs = [
    boost
    eigen
  ];

  cmakeFlags = [
    "-DARCH=generic;himbaechel"
  ];

  enableParallelBuilding = true;

  # Set up runtime paths
  # postInstall = ''
  #   wrapProgram $out/bin/nextpnr-ice40 \
  #     --prefix PATH : ${lib.makeBinPath [ icestorm ]}

  #   wrapProgram $out/bin/nextpnr-ecp5 \
  #     --prefix PATH : ${lib.makeBinPath [ trellis ]}

  #   if [ -f $out/bin/nextpnr-gowin ]; then
  #     wrapProgram $out/bin/nextpnr-gowin \
  #       --prefix PATH : ${lib.makeBinPath [ python3Packages.apycula ]}
  #   fi
  # '';

  meta = with lib; {
    description = "Portable FPGA place and route tool";
    longDescription = ''
      nextpnr is a vendor neutral, timing driven, FOSS FPGA place and route
      tool. Currently nextpnr supports:
      * Lattice iCE40 devices (through Project IceStorm)
      * Lattice ECP5 devices (through Project Trellis)
      * Gowin devices (through Apicula)
      * Generic FPGA architecture for research and education
    '';
    homepage = "https://github.com/YosysHQ/nextpnr";
    license = licenses.isc;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ ];
  };
}