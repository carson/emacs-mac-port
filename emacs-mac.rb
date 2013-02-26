require 'formula'

class EmacsMac <Formula
  homepage 'http://www.gnu.org/software/emacs/'

  head 'git://github.com/carson/emacs-mac-port.git'

  conflicts_with 'emacs'
  depends_on 'automake' => :build
  depends_on 'pkg-config' => :build

  depends_on 'd-bus' => [:optional, 'with-dbus']
  depends_on 'gnutls' => :optional
  depends_on 'imagemagick' => :optional
  depends_on 'libxml2' => [:optional, 'with-xml2']
  
  def caveats
    s = ""
    s += <<-EOS.undent

      This is an experimental home brew formula for GNU Emacs 24 by Carson Reynolds <carson@k2.t.u-tokyo.ac.jp>. 
      emacs-mac.rb is modified to check if emacs is already installed via brew.

    EOS

    s += <<-EOS.undent
        Emacs.app was installed to: /Applications

    EOS

    return s
  end

  def install
    args = ["--prefix=#{prefix}",
            "--enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp",
            "--infodir=#{info}/emacs",
            "--with-mac",
            "--enable-mac-app"]

    # build
    system "./configure", *args
    system "make"
    system "make install"

  end
end
