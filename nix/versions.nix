# Version configurations for custom-built EDA tools
# Only GHDL and NextPNR use custom builds - others use nixpkgs stable
{
  nextpnr = {
    owner = "YosysHQ";
    repo = "nextpnr";
    rev = "nextpnr-0.8"; # Latest stable release
  };

  ghdl = {
    owner = "ghdl";
    repo = "ghdl";
    rev = "1ed6445836f4101504c3da0bb95ce051351fb546"; # Latest master commit
  };

}