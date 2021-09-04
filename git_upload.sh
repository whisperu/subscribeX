#! /bin/bash

cd /root/source/subscribeX


contain_str="v2ray-"

for filename in $(ls)
do
   if [[ $filename == *$contain_str* ]];then
       before_random_num=${filename#*$contain_str}
   fi
done
         
random_num=$before_random_num
         
WEEK_DAY=$(TZ=GMT-8 date +%w)
         
if [[ `grep -c "星期 3" README.md` -eq 0 ]] && [[ $WEEK_DAY -eq 3 ]]; then
      
   #rm -rf `ls $before_random_num sed '/$before_random_num/'d`
   rm -rf link_url*
   rm -rf v2ray*
   rm -rf clash*
               
   random_num=$RANDOM
               
   sed -i "s/$before_random_num/$random_num/g"  README.md
fi
sed -i "1c 节点更新时间：`TZ=GMT-8 date +'%Y-%m-%d %H:%M:%S'` <!-- 星期 $WEEK_DAY -->" README.md




curl "https://classccai.oss-cn-beijing.aliyuncs.com/v2ray.txt" > v2ray.txt

curl "https://classccai.oss-cn-beijing.aliyuncs.com/link_url.txt" > link_url.txt

curl "https://classccai.oss-cn-beijing.aliyuncs.com/speed.png" > speed.png

curl "https://classccai.oss-cn-beijing.aliyuncs.com/qrcode.png" > qrcode.png

curl "https://subconverter.herokuapp.com/sub?target=clash&new_name=true&url=https%3A%2F%2Fclassccai.oss-cn-beijing.aliyuncs.com%2Fv2ray.txt&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini" > clash.yml

git pull
git add .
git commit -am "更新订阅链接"
git push
