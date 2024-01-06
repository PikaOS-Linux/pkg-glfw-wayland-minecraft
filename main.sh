DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/glfw/glfw -b 3.3.8 ./glfw-wayland-minecraft
cp -rvf ./debian ./glfw-wayland-minecraft
cd ./glfw-wayland-minecraft
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
