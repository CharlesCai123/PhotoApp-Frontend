# To update to newest flutter tar URL, go to https://docs.flutter.dev/get-started/install/linux
FLUTTER_TAR_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.0.1-stable.tar.xz

# To update to newest URL, go to https://developer.android.com/studio/index.html
ANDROID_STUDIO_TAR_URL=https://r2---sn-jvhj5nu-cvnr.gvt1.com/edgedl/android/studio/ide-zips/2021.2.1.15/android-studio-2021.2.1.15-linux.tar.gz?cms_redirect=yes&mh=BA&mip=73.89.29.65&mm=28&mn=sn-jvhj5nu-cvnr&ms=nvh&mt=1653706611&mv=u&mvi=2&pcm2cms=yes&pl=21&rmhost=r4---sn-jvhj5nu-cvnr.gvt1.com&shardbypass=sd&smhost=r2---sn-bvvbax-cvne.gvt1.com

WORKSPACE_DIR=~/workspace/

mkdir -p ${WORKSPACE_DIR}
cd ${WORKSPACE_DIR}


wget -O flutter.tar.xz ${FLUTTER_TAR_URL}

tar xf ${FILE_DIR}/flutter.tar.xz
rm flutter.tar.xz

export PATH="$PATH:`pwd`/flutter/bin"
echo export PATH="\$PATH:`pwd`/flutter/bin" >> ~/.bashrc

source ~/.bashrc
flutter doctor

echo
echo
echo !!!!!!!!!!!!!!!
echo Next, download Android Studio
echo
echo

cd ${WORKSPACE_DIR}
wget -O android_studio.tar.gz ${ANDROID_STUDIO_TAR_URL}
tar xf android_studio.tar.gz
rm android_studio.tar.gz

echo
echo
echo
echo Opening Android Studio at
echo ${WORKSPACE_DIR}/android-studio/bin/studio.sh
echo
echo
echo
./android-studio/bin/studio.sh


