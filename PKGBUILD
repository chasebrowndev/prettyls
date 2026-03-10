# Maintainer: Chase Brown <chase.brown.dev@gmail.com>
pkgname=prettyls
pkgver=1.0.0
pkgrel=1
pkgdesc="A prettier and more detailed ls."
arch=('any')
url="https://github.com/chasebrowndev/prettyls"
license=('MIT')
depends=('bash' 'coreutils' 'gawk' 'findutils')
optdepends=('curl: for automatic Nerd Font installation'
            'unzip: for automatic Nerd Font installation'
            'fontconfig: for automatic Nerd Font installation')
install=prettyls.install
source=("prettyls.sh::https://raw.githubusercontent.com/chasebrowndev/prettyls/v${pkgver}/prettyls.sh")
sha256sums=('2b8183dc0a741d4c8b54a57c0ff586540f20086a42987f9770ca750d56e81143')

package() {
    install -Dm755 "$startdir/prettyls.sh" "$pkgdir/usr/bin/prettyls"
}
