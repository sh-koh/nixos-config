{ stdenv
, lib
, writeText
, fetchFromGitHub
, python3Packages 
}:

python3Packages.buildPythonApplication rec {
  pname = "pogit";
  version = "git";

  src = fetchFromGitHub {
    owner = "y-syo";
    repo = "pogit";
    rev = "0b04dac5ea92c3bd9b52bd21800d3fdd51e92b1b";
    hash = "sha256-jRQJHWncmza6pEu9sX6gNdct3YzUD0yJ+sTJx8RIsT4=";
  };

}
