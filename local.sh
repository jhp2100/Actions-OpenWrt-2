

sudo -E apt-get update
sudo -E apt-get install $(curl -fsSL raw.githubusercontent.com/caonimagfw/Actions-K2P/openwrt/depend-2204)
sudo -E apt-get autoremove --purge
sudo -E apt-get clean
sudo timedatectl set-timezone "Asia/Shanghai"


mkdir workdir && cd workdir 


git clone -b openwrt-k2p https://github.com/caonimagfw/Actions-K2P .
git clone https://github.com/openwrt/openwrt -b openwrt-22.03 openwrt

cd openwrt
echo 'src-git helloworld https://github.com/caonimagfw/helloworld.git' >> feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install libpam
./scripts/feeds install liblzma
./scripts/feeds install libnetsnmp
./scripts/feeds install packages
./scripts/feeds install -a

[ -e files ] && mv files openwrt/files
[ -e patch_feeds ] && cp -rf patch_feeds/* openwrt/feeds
[ -e patch_package ] && cp -rf patch_package/* openwrt/package

echo 'net.ipv4.tcp_congestion_control=bbr' >> package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.default_qdisc=cake' >> package/base-files/files/etc/sysctl.d/10-default.conf
echo 'vm.min_free_kbytes=1024' >> package/base-files/files/etc/sysctl.d/10-default.conf

///

cd openwrt
echo -e 'CONFIG_DEVEL=y\nCONFIG_CCACHE=y' >> .config
make defconfig
make download -j8
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;