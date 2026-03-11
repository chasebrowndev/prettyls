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
sha256sums=('ab7b04a85b238766fe5aaffc2d97d66bf03c2259810babc6b156aca1a8756aae')

package() {
    install -Dm755 "$startdir/prettyls.sh" "$pkgdir/usr/bin/prettyls"
}
