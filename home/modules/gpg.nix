{pkgs, ...}: {
  # Install gpg via home-manager module
  programs.gpg = {
    enable = true;
    settings = {
      personal-cipher-preferences = "AES256";
      personal-digest-preferences = "SHA512";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 AES256 ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-key-origin = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

  services.gpg-agent = {
    enable =
      if pkgs.stdenv.isDarwin
      then false
      else true;
    defaultCacheTtl = 86400;
    enableSshSupport = true;
    pinentryPackage = if pkgs.stdenv.isDarwin
      then pkgs.pinentry_mac
      else pkgs.pinentry-gnome3;
  };

  programs.zsh = {
    initExtra = ''
      export GPG_TTY=$(tty)
    '';
  };
}
