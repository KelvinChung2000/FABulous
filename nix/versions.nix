# Version configurations for custom-built EDA tools
# Only GHDL and NextPNR use custom builds - others use nixpkgs stable
{
  nextpnr = {
    owner = "YosysHQ";
    repo = "nextpnr";
    rev = "nextpnr-0.8"; # Latest stable release
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Placeholder - run update-hashes.sh
  };

  ghdl = {
    owner = "ghdl";
    repo = "ghdl";
    rev = "1ed6445836f4101504c3da0bb95ce051351fb546"; # Latest master commit
    hash = "sha256-iGbU5pYljwG3nUrWcorSoHCcCRpd0/HH6AI3MH85bAA="; # Updated hash
  };

}