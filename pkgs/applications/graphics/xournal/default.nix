{ stdenv, fetchurl
, ghostscript, atk, gtk2, glib, fontconfig, freetype
, libgnomecanvas, libgnomeprint, libgnomeprintui
, pango, libX11, xproto, zlib, poppler
, autoconf, automake, libtool, pkgconfig}:
stdenv.mkDerivation rec {
  version = "0.4.8";
  name = "xournal-" + version;
  src = fetchurl {
    url = "mirror://sourceforge/xournal/${name}.tar.gz";
    sha256 = "0c7gjcqhygiyp0ypaipdaxgkbivg6q45vhsj8v5jsi9nh6iqff13";
  };

  buildInputs = [
    ghostscript atk gtk2 glib fontconfig freetype
    libgnomecanvas libgnomeprint libgnomeprintui
    pango libX11 xproto zlib poppler
  ];

  nativeBuildInputs = [ autoconf automake libtool pkgconfig ];

  NIX_LDFLAGS = [ "-lX11" "-lz" ];

  postInstall=''
      mkdir --parents $out/share/applications
      cat << EOF > $out/share/applications/xournal.desktop
      [Desktop Entry]
      Name=Xournal
      GenericName=PDF Editor
      Comment=Sketch or take notes with a stylus
      Exec=xournal
      Icon=$out/share/xournal/pixmaps/xournal.png
      Terminal=false
      Type=Application
      StartupNotify=false
      Categories=Office;Graphics;
      MimeType=application/pdf;application/x-xoj
      EOF
      mkdir --parents $out/share/mime/packages
      cat << EOF > $out/share/mime/packages/xournal.xml
      <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
         <mime-type type="application/x-xoj">
          <comment>Xournal Document</comment>
          <glob pattern="*.xoj"/>
         </mime-type>
      </mime-info>
      EOF
  '';

  meta = {
    homepage = http://xournal.sourceforge.net/;
    description = "Note-taking application (supposes stylus)";
    maintainers = [ stdenv.lib.maintainers.guibert ];
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
  };
}
