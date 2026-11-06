{ super }:

super.yabai.overrideAttrs (oldAttrs: {
  src = super.fetchFromGitHub {
    owner = "AhsanFazal";
    repo = "yabai";
    rev = "ad8d5adfdc39c76399599ae79a264f2525f6ca5e"; # Or pin to a specific commit
    hash = "sha256-berfA3vYih1YuCCSBEvpocCn2EPj+ZpftPmsE65ILWo="; # Replace with actual hash
  };
  dontBuild = false;
  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ super.apple-sdk_15 ];
  postPatch = ''
    substituteInPlace makefile \
      --replace-fail "-arch x86_64" ""
  '';
})
