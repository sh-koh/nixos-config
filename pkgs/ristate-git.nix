{ lib, rustPlatform, fetchFromGitLab }:

rustPlatform.buildRustPackage rec {
  pname = "ristate-git";
  version = "unstable-2023-23-08";

  src = fetchFromGitLab {
    owner = "snakedye";
    repo = "ristate";
    rev = "92e989f26cadac69af1208163733e73b4cf447da";
    sha256 = "sha256-6slH7R6kbSXQBd7q38oBEbngaCbFv0Tyq34VB1PAfhM=";
  };

  cargoSha256 = "sha256-UYkg0cewnxo8f5M2ZFZh1alEfKMAOO4doz1pGHGLLzU=";
}
