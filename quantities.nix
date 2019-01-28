{ build-idris-package
, lib
}:
build-idris-package {
  name = "quantities";
  version = "2019-01-28";

  ipkgName = "quantities";
  idrisDeps = [ ];

  src = ./.;

  meta = {
    description = "Idris lib for type-safe computing with physical units";
    homepage = https://github.com/timjb/quantities;
    license = lib.licenses.mit;
  };
}