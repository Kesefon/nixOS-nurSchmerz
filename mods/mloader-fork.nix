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
    rev = "7e2b92d792c95d5223a150341180369623fdf509";
    hash = "sha256-KfLuReeO2Se3UZrjfA6SP936MZVfW/pNRUQDxJdWpHg=";
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
