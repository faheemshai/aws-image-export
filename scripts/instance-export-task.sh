#!/usr/bin/env bash

# https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
#aws ec2 create-instance-export-task \
#    --profile  \
#    --instance-id $1 \
#    --description "bitme ec2 instance backup" \
#    --target-environment vmware \
#    --export-to-s3-task DiskImageFormat=vmdk,ContainerFormat=ova,S3Bucket=$2
ec2_id=${INSTANCE_ID}
s3_name=${S3bucket_name}
region=${Region}
export_id=$(aws ec2 create-instance-export-task  --instance-id ${ec2_id} --description "ec2 instance backup" --target-environment citrix --export-to-s3-task DiskImageFormat=vhd,S3Bucket=${s3_name} --region ${region} | grep ExportTaskId | awk '{print $2}' | sed "s/\"//g" | sed "s/\,//g" |  sed "s/ //g")
sleep 5s
echo "${export_id}.vhd" > imagename.txt
count=0

while true ; do
  export_status=$(aws ec2 describe-export-tasks --export-task-ids ${export_id} --region ${region} | grep State | awk '{print $2}' | sed "s/\"//g")
  
  echo "export_status : ${export_status}"
  if [[ ${count} -gt 15 ]]; then
    echo "Timed out waiting for Image status to be ready"
    break;
  else 
     
    if [[ ${export_status} ==  "completed" ]]; then
      echo "Image created and in  ready status"
      break;
    fi
    if [[ ${export_status} ==  "error" ]]; then
      echo "Image creation in error state. Please review logs."
      exit 1;
    fi
  fi
  
  count=$((count + 1)) 
  echo "Waiting for Image export - ${export_id} status to be ready "
  sleep 120
done