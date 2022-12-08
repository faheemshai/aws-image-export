resource null_resource export-Instance {   

  provisioner "local-exec" {
    command = "${path.module}/scripts/instance-export-task.sh"
    working_dir = path.root
    environment = {
      INSTANCE_ID     = var.instance_ID
      S3bucket_name   = var.src_bucket
      Region          = var.src_provider_region
    }
  }  
}

data "local_file" "image-name" {
    filename = "${path.module}/imagename.txt"
    depends_on = [null_resource.export-Instance]
}