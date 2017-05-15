{ stdenv, fetchurl, libextractor, gnunet, gtk3, glade, pkgconfig, libxml2, libunique3, qrencode
  ,libgcrypt, autoconf, gettext, automake, libtool # random stuff?
}:

stdenv.mkDerivation rec {
  version = "0.10.1";
  name = "gnunet-gtk-${version}";

  src = fetchurl {
    url = "http://ftpmirror.gnu.org/gnunet/${name}.tar.gz";
    sha256 = "8fac6aa405a0cca149b3ca373c0d80a932dff20f8e1d959863d50965749868dc";
  };

  buildInputs = [
    libextractor gtk3 glade gnunet pkgconfig libxml2 libunique3 qrencode libgcrypt
    autoconf gettext automake libtool # random stuff?
  ];

  # This just breaks things if un-commented
  # preConfigure  = ''
  #   autoreconf -vfi
  # '';

  configureFlags = [
    "--with-gnunet=${gnunet}"
    "--with-libunique"
    "--with-qrencode"
  ];

  # Toggling these doesn't seem to change the build
  # dontAddDisableDepTrack = true;
  # dontFixLibtool = true;
  # dontDisableStatic = true;

  meta = with stdenv.lib; {
    description = "GTK interfaces for GNU's decentralized anonymous and censorship-resistant P2P framework";
    license = licenses.gpl3;
    homepage = http://gnunet.org/;
    maintainers = with maintainers; [ lverns ];
    platforms = platforms.gnu;
  };

}
