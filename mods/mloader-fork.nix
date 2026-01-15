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
    rev = "0e1d7e5301aee16581a4d498f552ede36684fc95";
    hash = "sha256-txVIFDqy3UJPXYnYzWhnC0Aejn4FeX4Eed+W//E12aI=";
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
