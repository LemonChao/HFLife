#!/bin/sh
# 该脚本使用方法
# 源码地址：https://github.com/stackhou
# step 1. 在工程根目录新建Shell文件夹，在该文件夹中新建文件autopacking.sh，将该脚本复制到autopacking.sh文件并保存(或者直接复制该文件);
# step 2. 配置该脚本;
# step 2. cd 该脚本目录，运行chmod +x autopacking.sh;
# step 3. 终端运行 sh autopacking.sh;
# step 4. 选择不同选项....
# step 5. Success  🎉 🎉 🎉!

# ************************* 配置 Start ********************************

# 上传到蒲公英
__PGYER_U_KEY="bd1102006599c4c771421741f730fe0e"
__PGYER_API_KEY="db2c3a7a08a9fb856eea49648fa8a3bd"

# 上传到 Fir
__FIR_API_TOKEN="xKKdjdldlodeikK626266skdkkddK"

# 证书
__CODE_SIGN_DISTRIBUTION="iPhone Distribution: Hangzhou Hanfu Commerce Development Co., Ltd. (5PUNUXX6F8)"
__CODE_SIGN_DEVELOPMENT="iOS Developer: Qiang Wang (CKAB9NBHCF)"

# 换行符
__LINE_BREAK_LEFT="\n\033[32;1m*********"
__LINE_BREAK_RIGHT="***************\033[0m\n"
__SLEEP_TIME=0.3


## 指定Target
#echo "\033[36;1m请选择 SCHEME (输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. RegistrationHall \033[0m"
#echo "\033[33;1m2. RegistrationHallTest \033[0m"
#echo "\033[33;1m3. RegistrationHallRelease \033[0m"
#echo "\033[33;1m4. RegistrationHallAppStore \033[0m\n"
#
#read parameter
#sleep ${__SLEEP_TIME}
#__SCHEME_NAME_SELECTED="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__SCHEME_NAME_SELECTED}" == "1" ]]; then
#__SCHEME_NAME="RegistrationHall"
#elif [[ "${__SCHEME_NAME_SELECTED}" == "2" ]]; then
#__SCHEME_NAME="RegistrationHallTest"
#elif [[ "${__SCHEME_NAME_SELECTED}" == "3" ]]; then
#__SCHEME_NAME="RegistrationHallRelease"
#elif [[ "${__SCHEME_NAME_SELECTED}" == "4" ]]; then
#__SCHEME_NAME="RegistrationHallAppStore"
#else
#echo "${__LINE_BREAK_LEFT} 您输入 SCHEME 参数无效!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi

# ************************* 配置 END ********************************

## 指定打包编译的模式，如：Release, Debug...
#echo "\033[36;1m请选择 BUILD_CONFIGURATION (输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. Debug \033[0m"
#echo "\033[33;1m2. Release \033[0m"
#
#read parameter
#sleep ${__SLEEP_TIME}
#__BUILD_CONFIGURATION_SELECTED="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__BUILD_CONFIGURATION_SELECTED}" == "1" ]]; then
#__BUILD_CONFIGURATION="Debug"
#elif [[ "${__BUILD_CONFIGURATION_SELECTED}" == "2" ]]; then
#__BUILD_CONFIGURATION="Release"
#else
#echo "${__LINE_BREAK_LEFT} 您输入 BUILD_CONFIGURATION 参数无效!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi

## 工程类型(.xcworkspace项目,赋值true; .xcodeproj项目, 赋值false)
#echo "\033[36;1m请选择是否是.xcworkspace项目(输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. 是 \033[0m"
#echo "\033[33;1m2. 否 \033[0m"
#
#read parameter
#sleep ${__SLEEP_TIME}
#__IS_WORKSPACE_SELECTE="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__IS_WORKSPACE_SELECTE}" == "1" ]]; then
#__IS_WORKSPACE=true
#elif [[ "${__IS_WORKSPACE_SELECTE}" == "2" ]]; then
#__IS_WORKSPACE=false
#else
#echo "${__LINE_BREAK_LEFT} 您输入是否是.xcworkspace项目 参数无效!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi

## AdHoc, AppStore, Enterprise, Development
#echo "\033[36;1m请选择打包方式(输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. AdHoc \033[0m"
#echo "\033[33;1m2. AppStore \033[0m"
#echo "\033[33;1m3. Enterprise \033[0m"
#echo "\033[33;1m4. Development \033[0m\n"
## 读取用户输入并存到变量里
#read parameter
#sleep ${__SLEEP_TIME}
#__BUILD_METHOD="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__BUILD_METHOD}" == "1" ]]; then
#ExportOptionsPlistPath="./Shell/Plist/AdHocExportOptionsPlist.plist"
#elif [[ "${__BUILD_METHOD}" == "2" ]]; then
#ExportOptionsPlistPath="./Shell/Plist/AppStoreExportOptionsPlist.plist"
#elif [[ "${__BUILD_METHOD}" == "3" ]]; then
#ExportOptionsPlistPath="./Shell/Plist/EnterpriseExportOptionsPlist.plist"
#elif [[ "${__BUILD_METHOD}" == "4" ]]; then
#ExportOptionsPlistPath="./Shell/Plist/DevelopmentExportOptionsPlist.plist"
#else
#echo "${__LINE_BREAK_LEFT} 您输入的打包方式参数无效!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi

## 选择内测网站 用Fir或者pgyer
#echo "\033[36;1m请选择ipa内测发布平台 (输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. None \033[0m"
#echo "\033[33;1m2. Pgyer \033[0m"
#echo "\033[33;1m3. Fir \033[0m"
#echo "\033[33;1m4. Pgyer and Fir \033[0m\n"
#
## 读取用户输入并存到变量里
#read parameter
#sleep ${__SLEEP_TIME}
#__UPLOAD_TYPE_SELECTED="${parameter}"

## 成功出包后是否自动打开文件夹
#echo "\033[36;1m成功出包后是否自动打开文件夹(输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. 是 \033[0m"
#echo "\033[33;1m2. 否 \033[0m"
#
#read parameter
#sleep ${__SLEEP_TIME}
#__IS_AUTO_OPENT_FILE_SELECTED="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__IS_AUTO_OPENT_FILE_SELECTED}" == "1" ]]; then
#__IS_AUTO_OPENT_FILE=true
#elif [[ "${__IS_AUTO_OPENT_FILE_SELECTED}" == "2" ]]; then
#__IS_AUTO_OPENT_FILE=false
#else
#echo "${__LINE_BREAK_LEFT} 您输入的成功出包后是否自动打开文件夹 参数错误!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi

#echo "${__LINE_BREAK_LEFT} 您选择了 ${__SCHEME_NAME}-${__BUILD_CONFIGURATION} 模式 ${__LINE_BREAK_RIGHT}"

## 配置完毕是否开始打包
#echo "\033[36;1m配置完毕是否立即开始打包 (输入序号, 按回车即可) \033[0m"
#echo "\033[33;1m1. 是 \033[0m"
#echo "\033[33;1m2. 否 \033[0m"
#
#read parameter
#sleep ${__SLEEP_TIME}
#__IS_START_PACKINF="${parameter}"
#
## 判读用户是否有输入
#if [[ "${__IS_START_PACKINF}" == "1" ]]; then
#echo "${__LINE_BREAK_LEFT} 立即开始 ${__LINE_BREAK_RIGHT}"
#elif [[ "${__IS_START_PACKINF}" == "2" ]]; then
#echo "${__LINE_BREAK_LEFT} 您退出了打包 ${__LINE_BREAK_RIGHT}"
#exit 1
#else
#echo "${__LINE_BREAK_LEFT} 您输入 是否立即开始打包 参数无效!!! ${__LINE_BREAK_RIGHT}"
#exit 1
#fi
# 设置ipa包显示名称
__SCHEME_NAME="HFLife"
# 设置打包编译模式
__BUILD_CONFIGURATION="Release"
# 是否包含WORKSPACE项目
__IS_WORKSPACE=true
# 出包配置文件
ExportOptionsPlistPath="./Shell/Plist/AdHocExportOptionsPlist.plist"
# 2:上传到pyger平台
__UPLOAD_TYPE_SELECTED="2"
# 成功出包后是否自动打开文件夹
__IS_AUTO_OPENT_FILE=true
# 配置完毕是否立即开始打包
__IS_START_PACKINF="1"
echo "\033[36;1m Archive默认配置,即将开始自动打包 \033[0m"
echo "\033[33;1m1. __SCHEME_NAME=${__SCHEME_NAME} \033[0m"
echo "\033[33;1m2. __BUILD_CONFIGURATION=${__BUILD_CONFIGURATION} \033[0m"
echo "\033[33;1m3. __IS_WORKSPACE=${__IS_WORKSPACE} \033[0m"
echo "\033[33;1m2. ExportOptionsPlistPath=${ExportOptionsPlistPath} \033[0m"
echo "\033[33;1m2. __UPLOAD_TYPE_SELECTED=${__UPLOAD_TYPE_SELECTED} \033[0m"
echo "\033[33;1m2. __IS_AUTO_OPENT_FILE=${__IS_AUTO_OPENT_FILE} \033[0m"
echo "\033[33;1m2. __IS_START_PACKINF=${__IS_START_PACKINF} \033[0m"



# 输入更新日志
echo "${__LINE_BREAK_LEFT} 请输入此版本的更新日志 ${__LINE_BREAK_RIGHT}"
sleep 2

vi description.txt
__Update_Description=$(cat description.txt)
echo "${__Update_Description}"

rm description.txt
echo "${__LINE_BREAK_LEFT} 立即开始 ${__LINE_BREAK_RIGHT}"


# ===============================自动打包部分=============================

echo "${__LINE_BREAK_LEFT} 使用打包配置文件路径=${ExportOptionsPlistPath} ${__LINE_BREAK_RIGHT}"
# 打包计时
__CONSUME_TIME=0
# 回退到工程目录
cd ../
__PROGECT_PATH=`pwd`
echo "${__LINE_BREAK_LEFT} 进入工程目录=${__PROGECT_PATH} ${__LINE_BREAK_RIGHT}"

# 获取项目名称
__PROJECT_NAME=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`

# 已经指定Target的Info.plist文件路径
#__CURRENT_INFO_PLIST_NAME="${__SCHEME_NAME}-Info.plist"
# 获取 Info.plist 路径
#__CURRENT_INFO_PLIST_PATH="${__PROJECT_NAME}/Configs/${__CURRENT_INFO_PLIST_NAME}"
#AutoArchive/Configs/AutoArchive-Info.plist

__CURRENT_INFO_PLIST_PATH="${__SCHEME_NAME}/Info.plist"

# 当前的plist文件路径
echo "${__LINE_BREAK_LEFT} 当前Info.plist路径= ${__CURRENT_INFO_PLIST_PATH} ${__LINE_BREAK_RIGHT}"
# 获取版本号
__BUNDLE_VERSION=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" ${__CURRENT_INFO_PLIST_PATH}`
# 获取编译版本号
__BUNDLE_BUILD_VERSION=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" ${__CURRENT_INFO_PLIST_PATH}`

# 打印版本信息
echo "${__LINE_BREAK_LEFT} 打包版本=${__BUNDLE_VERSION} 编译版本=${__BUNDLE_BUILD_VERSION} ${__LINE_BREAK_RIGHT}"

# 获取时间 如:2017-06-01_13-14-5"
__CURRENT_DATE="$(date +%Y-%m-%d_%H-%M-%S)"
# 编译生成文件目录
__EXPORT_PATH="./build/${__CURRENT_DATE}"

# 指定输出文件目录不存在则创建
if test -d "${__EXPORT_PATH}" ; then
echo "${__LINE_BREAK_LEFT} 保存归档文件和ipa的路径=${__EXPORT_PATH} ${__LINE_BREAK_RIGHT}"
rm -rf ${__EXPORT_PATH}
else
mkdir -pv ${__EXPORT_PATH}
fi

# 归档文件路径
__EXPORT_ARCHIVE_PATH="${__EXPORT_PATH}/${__SCHEME_NAME}.xcarchive"
# ipa 导出路径
__EXPORT_IPA_PATH="${__EXPORT_PATH}"
# ipa 名字
__IPA_NAME="${__SCHEME_NAME}_build${__BUNDLE_BUILD_VERSION}"

echo "${__LINE_BREAK_LEFT} 打包APP名字=${__IPA_NAME} ${__LINE_BREAK_RIGHT}"

# 修改编辑版本
#__SET_BUNDLE_BUILD_VERSION="${__BUNDLE_BUILD_VERSION}.${__CURRENT_DATE}"
#/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${__SET_BUNDLE_BUILD_VERSION}" "${__CURRENT_INFO_PLIST_PATH}"

echo "${__LINE_BREAK_LEFT} 开始构建项目 ${__LINE_BREAK_RIGHT}"

if ${__IS_WORKSPACE} ; then
#echo "${__LINE_BREAK_LEFT} 开始pod ${__LINE_BREAK_RIGHT}"
#pod install --verbose --no-repo-update
#echo "${__LINE_BREAK_LEFT} pod完成 ${__LINE_BREAK_RIGHT}"

if [[ ${__BUILD_CONFIGURATION} == "Debug" ]]; then
echo "${__LINE_BREAK_LEFT} 您选择了以 xcworkspace-Debug 模式打包 ${__LINE_BREAK_RIGHT}"
# step 1. Clean
xcodebuild clean  -workspace ${__PROJECT_NAME}.xcworkspace \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION}

# step 2. Archive
xcodebuild archive  -workspace ${__PROJECT_NAME}.xcworkspace \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-archivePath ${__EXPORT_ARCHIVE_PATH} \
CFBundleVersion=${__BUNDLE_BUILD_VERSION} \
-destination generic/platform=ios \
CODE_SIGN_IDENTITY="${__CODE_SIGN_DEVELOPMENT}"

elif [[ ${__BUILD_CONFIGURATION} == "Release" ]]; then
echo "${__LINE_BREAK_LEFT} 您选择了以 xcworkspace-Release 模式打包 ${__LINE_BREAK_RIGHT}"
# step 1. Clean
xcodebuild clean  -workspace ${__PROJECT_NAME}.xcworkspace \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION}

# step 2. Archive
xcodebuild archive  -workspace ${__PROJECT_NAME}.xcworkspace \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-archivePath ${__EXPORT_ARCHIVE_PATH} \
CFBundleVersion=${__BUNDLE_BUILD_VERSION} \
-destination generic/platform=ios \
CODE_SIGN_IDENTITY="${__CODE_SIGN_DISTRIBUTION}"
else
echo "${__LINE_BREAK_LEFT} 您输入的参数不对 😢 😢 😢 ${__LINE_BREAK_RIGHT}"
echo "Usage:\n"
echo "sh autopacking.sh"
echo "sh autopacking.sh"
exit 1
fi
else
if [[ ${__BUILD_CONFIGURATION} == "Debug" ]] ; then
echo "${__LINE_BREAK_LEFT}您选择了以 xcodeproj-Debug 模式打包 ${__LINE_BREAK_RIGHT}"
# step 1. Clean
xcodebuild clean  -project ${__PROJECT_NAME}.xcodeproj \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-alltargets

# step 2. Archive
xcodebuild archive  -project ${__PROJECT_NAME}.xcodeproj \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-archivePath ${__EXPORT_ARCHIVE_PATH} \
CFBundleVersion=${__BUNDLE_BUILD_VERSION} \
-destination generic/platform=ios \
CODE_SIGN_IDENTITY="${__CODE_SIGN_DEVELOPMENT}"


elif [[ ${__BUILD_CONFIGURATION} == "Release" ]]; then
echo "${__LINE_BREAK_LEFT} 您选择了以 xcodeproj-Release 模式打包 ${__LINE_BREAK_RIGHT}"
# step 1. Clean
xcodebuild clean  -project ${__PROJECT_NAME}.xcodeproj \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-alltargets
# step 2. Archive
xcodebuild archive  -project ${__PROJECT_NAME}.xcodeproj \
-scheme ${__SCHEME_NAME} \
-configuration ${__BUILD_CONFIGURATION} \
-archivePath ${__EXPORT_ARCHIVE_PATH} \
CFBundleVersion=${__BUNDLE_BUILD_VERSION} \
-destination generic/platform=ios \
CODE_SIGN_IDENTITY="${__CODE_SIGN_DISTRIBUTION}"

else
echo "${__LINE_BREAK_LEFT} 您输入的参数不对 😢 😢 😢 ${__LINE_BREAK_RIGHT}"
echo "Usage:\n"
echo "sh autopacking.sh"
echo "sh autopacking.sh"
exit 1
fi
fi

# 检查是否构建成功
# xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断
if test -d "${__EXPORT_ARCHIVE_PATH}" ; then
echo "${__LINE_BREAK_LEFT} 项目构建成功 🚀 🚀 🚀 ${__LINE_BREAK_RIGHT}"
else
echo "${__LINE_BREAK_LEFT} 项目构建失败 😢 😢 😢 ${__LINE_BREAK_RIGHT}"
exit 1
fi

echo "${__LINE_BREAK_LEFT} 开始导出ipa文件 ${__LINE_BREAK_RIGHT}"

xcodebuild -exportArchive -archivePath ${__EXPORT_ARCHIVE_PATH} \
-exportPath ${__EXPORT_IPA_PATH} \
-destination generic/platform=ios \
-exportOptionsPlist ${ExportOptionsPlistPath} \
-allowProvisioningUpdates

# 修改ipa文件名称
mv ${__EXPORT_IPA_PATH}/${__SCHEME_NAME}.ipa ${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa

# 检查文件是否存在
if test -f "${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa" ; then
echo "${__LINE_BREAK_LEFT} 导出 ${__IPA_NAME}.ipa 包成功 🎉 🎉 🎉 ${__LINE_BREAK_RIGHT}"

if test -n "${__UPLOAD_TYPE_SELECTED}"
then

if [[ "${__UPLOAD_TYPE_SELECTED}" == "1" ]] ; then
echo "${__LINE_BREAK_LEFT} 您选择了不上传到内测网站 ${__LINE_BREAK_RIGHT}"
elif [[ "${__UPLOAD_TYPE_SELECTED}" == "2" ]]; then
echo "${__LINE_BREAK_LEFT} 开始上传 ${__IPA_NAME}.ipa 包 pgyer 🕺🕺${__LINE_BREAK_RIGHT}"

curl -F "file=@${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa" \
-F "_api_key=$__PGYER_API_KEY" \
-F "buildUpdateDescription=${__Update_Description}" \
"https://www.pgyer.com/apiv2/app/upload"

echo "${__LINE_BREAK_LEFT} 上传 ${__IPA_NAME}.ipa 包 到 pgyer 成功 🎉 🎉 🎉 ${__LINE_BREAK_RIGHT}"
elif [[ "${__UPLOAD_TYPE_SELECTED}" == "3" ]]; then

fir login -T ${__FIR_API_TOKEN}
fir publish "${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa"

echo "${__LINE_BREAK_LEFT} 上传 ${__IPA_NAME}.ipa 包 到 fir 成功 🎉 🎉 🎉 ${__LINE_BREAK_RIGHT}"
elif [[ "${__UPLOAD_TYPE_SELECTED}" == "4" ]]; then

fir login -T ${__FIR_API_TOKEN}
fir publish "${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa"

echo "${__LINE_BREAK_LEFT} 上传 ${__IPA_NAME}.ipa 包 到 fir 成功 🎉 🎉 🎉 ${__LINE_BREAK_RIGHT}"

curl -F "file=@${__EXPORT_IPA_PATH}/${__IPA_NAME}.ipa" \
-F "_api_key=$__PGYER_API_KEY" \
-F "buildUpdateDescription=${__Update_Description}" \
"https://www.pgyer.com/apiv2/app/upload"

echo "${__LINE_BREAK_LEFT} 上传 ${__IPA_NAME}.ipa 包 到 pgyer 成功 🎉 🎉 🎉 ${__LINE_BREAK_RIGHT}"
else
echo "${__LINE_BREAK_LEFT} 您输入 上传内测网站 参数无效!!! ${__LINE_BREAK_RIGHT}"
exit 1
fi

# 自动打开文件夹
if ${__IS_AUTO_OPENT_FILE} ; then
# open ${__EXPORT_IPA_PATH}
# 打开pyger应用下载页
open 'https://www.pgyer.com/qpg8'
fi

fi

else
echo "${__LINE_BREAK_LEFT} 导出 ${__IPA_NAME}.ipa 包失败 😢 😢 😢 ${__LINE_BREAK_RIGHT}"
exit 1
fi

# 输出打包总用时
echo "${__LINE_BREAK_LEFT} 使用YJShell脚本打包总耗时: ${SECONDS}s ${__LINE_BREAK_RIGHT}"
