{ lib, rustPlatform, fetchFromGitLab }:

rustPlatform.buildRustPackage rec {
  pname = "ristate-git";
  version = "git";

  src = fetchFromGitLab {
    owner = "snakedye";
    repo = "ristate";
    rev = "92e989f26cadac69af1208163733e73b4cf447da";
    sha256 = "sha256-6slH7R6kbSXQBd7q38oBEbngaCbFv0Tyq34VB1PAfhM=";
  };

  cargoSha256 = "sha256-omQHSu97JjgCNxwLezFu53LHRUIbDe6jS31CUidxK2A=";
}
