#!/bin/bash

#set the path to nginx log files
log_files_path="/home/wwwlogs/"
log_files_dir=${log_files_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")
#set nginx log files you want to cut
log_files_name=(access vpser)
#set the path to nginx
nginx_sbin="/usr/local/nginx/sbin/nginx"
nginx_pid="/usr/local/nginx/nginx.pid"
#set how long you want to save
save_days=30


#############################################
# Please do not modify the following script #
#############################################
mkdir -p $log_files_dir

log_files_num=${#log_files_name[@]}

#cut nginx log files
for((i=0;i<$log_files_num;i++));do
    #主要是这一步切分
    mv ${log_files_path}${log_files_name[i]}.log ${log_files_dir}/${log_files_name[i]}_$(date -d "yesterday" +"%Y%m%d").log
done

#reload nginx
#向nginx主进程发送信号重新打开日志
kill -USR1 `cat ${nginx_pid}` #(这步很重要！！！，nginx在多个server情况下不会自动重建access_log文件) 
$nginx_sbin -s reload

#delete 30 days ago nginx log files
find ${log_files_path} -mtime +${save_days} -exec rm -rf {} \;
