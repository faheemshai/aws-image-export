resource null_resource export-Instance {   

  provisioner "local-exec" {
    command = "${path.module}/scripts/instance-export-task.sh"
    working_dir = path.root
    environment = {
      INSTANCE_ID     = var.instance_ID
      S3bucket_name   = var.S3Bucket_name
      Region          = var.region
    }
  }
}