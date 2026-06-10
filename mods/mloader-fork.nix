{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonApplication rec {
  pname = "mloader-fork";
  version = "1.1.12";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kesefon";
    repo = "mloader";
    rev = "9be124ddfa513ed055356bc92295a2f403bfbd1e";
    hash = "sha256-Jeg4hbg+2y6Lub/D84as1EhPxU8PBj//X3zRHMkN0m0=";
  };

  build-system = with python3Packages; [ setuptools ];

  pythonRelaxDeps = [ "protobuf" ];

  dependencies = with python3Packages; [
    click
    protobuf
    requests
  ];

  # No tests in repository
  doCheck = false;

  pythonImportsCheck = [ "mloader" ];

  meta = {
    description = "Command-line tool to download manga from mangaplus";
    homepage = "https://github.com/kesefon/mloader";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "mloader";
  };
}
